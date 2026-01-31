local wezterm = require("wezterm")

local config = wezterm.config_builder and wezterm.config_builder() or {}
local act = wezterm.action
local mux = wezterm.mux
local serde = wezterm.serde
local function safe_home_dir()
  if type(wezterm.home_dir) == "function" then
    local ok, value = pcall(wezterm.home_dir)
    if ok and value then
      return value
    end
  elseif type(wezterm.home_dir) == "string" then
    return wezterm.home_dir
  end

  return os.getenv("HOME") or ""
end

local function safe_config_dir(home)
  if type(wezterm.config_dir) == "function" then
    local ok, value = pcall(wezterm.config_dir)
    if ok and value then
      return value
    end
  elseif type(wezterm.config_dir) == "string" then
    return wezterm.config_dir
  end

  return home ~= "" and (home .. "/.config/wezterm") or "."
end

local home_dir = safe_home_dir()
local config_dir = safe_config_dir(home_dir)
local session_file = config_dir .. "/wezterm-session.json"

local project_profiles = {
  {
    name = "utils-scripts",
    cwd = home_dir .. "/Codes/Projects/utils-scripts",
    workspace = "main",
    font_size = 13.0,
    opacity = 0.96,
    blur = 18,
  },
  {
    name = "projects",
    cwd = home_dir .. "/Codes/Projects",
    workspace = "main",
    font_size = 13.0,
    opacity = 0.98,
    blur = 14,
  },
}

local function basename(path)
  if not path or path == "" then
    return ""
  end

  local cleaned = path:gsub("/*$", "")
  return cleaned:match("([^/]+)$") or cleaned
end

local function expand_path(path)
  if not path or path == "" then
    return nil
  end

  if path == "~" then
    return home_dir
  end

  if path:sub(1, 2) == "~/" then
    return home_dir .. path:sub(2)
  end

  return path
end

local function normalize_path(path)
  local expanded = expand_path(path)
  if not expanded then
    return nil
  end

  return expanded:gsub("/*$", "")
end

local function path_from_cwd(cwd)
  if not cwd then
    return nil
  end

  if type(cwd) == "userdata" and cwd.file_path then
    return cwd.file_path
  end

  if type(cwd) == "string" then
    return cwd:gsub("^file://", "")
  end

  if cwd.file_path then
    return cwd.file_path
  end

  return nil
end

local function pane_cwd_path(pane)
  if not pane then
    return nil
  end

  local cwd = path_from_cwd(pane:get_current_working_dir())
  if not cwd then
    cwd = path_from_cwd(pane.current_working_dir)
  end

  return normalize_path(cwd)
end

local function match_project_profile(path)
  local normalized = normalize_path(path)
  if not normalized then
    return nil
  end

  for _, profile in ipairs(project_profiles) do
    local profile_path = normalize_path(profile.cwd)
    if profile_path and normalized:find(profile_path, 1, true) == 1 then
      return profile
    end
  end

  return nil
end

local function build_launch_menu()
  local menu = {
    {
      label = "Home",
      cwd = home_dir,
      args = { "zsh", "-l" },
    },
  }

  for _, profile in ipairs(project_profiles) do
    table.insert(menu, {
      label = "Project: " .. profile.name,
      cwd = profile.cwd,
      args = { "zsh", "-l" },
    })
  end

  return menu
end

local function cwd_name(pane)
  local path = pane_cwd_path(pane)
  if not path or path == "" then
    return ""
  end

  return basename(path)
end

local function process_name(pane)
  local process = pane:get_foreground_process_name()
  if not process then
    return ""
  end

  return basename(process)
end

local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "UtilsScripts Dark"
  end

  return "UtilsScripts Light"
end

local function tab_title_for_pane(tab)
  local title = tab.tab_title
  local index = tab.tab_index + 1
  if title and title ~= "" then
    return string.format(" %d:%s ", index, title)
  end

  local pane = tab.active_pane
  local dir = cwd_name(pane)
  local process = process_name(pane)
  local zoomed = pane.is_zoomed and "Z" or ""
  local label_parts = {}

  if zoomed ~= "" then
    table.insert(label_parts, zoomed)
  end
  if dir ~= "" then
    table.insert(label_parts, dir)
  end
  if process ~= "" then
    table.insert(label_parts, process)
  end

  local label = #label_parts > 0 and table.concat(label_parts, " | ") or pane.title
  return string.format(" %d:%s ", index, label)
end

local function prompt_tab_title()
  return act.PromptInputLine({
    description = "Tab title",
    action = wezterm.action_callback(function(window, _, line)
      if line and line ~= "" then
        window:active_tab():set_title(line)
      end
    end),
  })
end

local function battery_status()
  local batteries = wezterm.battery_info()
  if #batteries == 0 then
    return nil, false
  end

  local lowest = 1.0
  local state = "Unknown"
  for _, battery in ipairs(batteries) do
    if battery.state_of_charge < lowest then
      lowest = battery.state_of_charge
    end
    if battery.state == "Discharging" then
      state = "Discharging"
    elseif battery.state == "Charging" and state ~= "Discharging" then
      state = "Charging"
    elseif state == "Unknown" then
      state = battery.state
    end
  end

  local percent = math.floor(lowest * 100 + 0.5)
  local suffix = ""
  if state == "Charging" then
    suffix = "+"
  elseif state == "Discharging" then
    suffix = "-"
  end

  return string.format("bat:%d%%%s", percent, suffix), state == "Discharging"
end

local function git_branch_for_pane(pane)
  if not pane then
    return nil
  end

  local vars = pane:get_user_vars()
  local branch = vars.WEZTERM_GIT_BRANCH or vars.GIT_BRANCH or vars.git_branch
  if branch and branch ~= "" then
    return branch
  end

  return nil
end

local function project_label_for_pane(pane)
  if not pane then
    return nil
  end

  local vars = pane:get_user_vars()
  local label = vars.WEZTERM_PROJECT or vars.WEZTERM_WORKSPACE or vars.PROJECT
  if label and label ~= "" then
    return label
  end

  local profile = match_project_profile(pane_cwd_path(pane))
  return profile and profile.name or nil
end

local function apply_window_overrides(window, pane)
  local overrides = {}
  local profile = match_project_profile(pane_cwd_path(pane))
  if profile then
    if profile.font_size then
      overrides.font_size = profile.font_size
    end
    if profile.opacity then
      overrides.window_background_opacity = profile.opacity
    end
    if profile.blur then
      overrides.macos_window_background_blur = profile.blur
    end
    if profile.window_padding then
      overrides.window_padding = profile.window_padding
    end
    if profile.color_scheme then
      overrides.color_scheme = profile.color_scheme
    end
  end

  local _, on_battery = battery_status()
  if on_battery then
    overrides.max_fps = 60
    overrides.animation_fps = 30
    overrides.webgpu_power_preference = "LowPower"
    overrides.window_background_opacity = 1.0
    overrides.macos_window_background_blur = 0
  end

  if next(overrides) == nil then
    window:set_config_overrides(nil)
  else
    window:set_config_overrides(overrides)
  end
end

local function read_session()
  local file = io.open(session_file, "r")
  if not file then
    return nil
  end

  local contents = file:read("*a")
  file:close()
  if not contents or contents == "" then
    return nil
  end

  local ok, decoded = pcall(serde.json_decode, contents)
  if not ok then
    return nil
  end

  return decoded
end

local function write_session(session)
  local ok, encoded = pcall(serde.json_encode_pretty, session)
  if not ok then
    return false
  end

  local file = io.open(session_file, "w")
  if not file then
    return false
  end

  file:write(encoded)
  file:close()
  return true
end

local function capture_session()
  local session = { version = 1, windows = {} }
  for _, window in ipairs(mux.all_windows()) do
    local window_info = {
      workspace = window:get_workspace(),
      tabs = {},
    }

    for _, tab_info in ipairs(window:tabs_with_info()) do
      local tab = tab_info.tab
      local pane = tab:active_pane()
      table.insert(window_info.tabs, {
        cwd = pane_cwd_path(pane),
        title = tab:get_title(),
        is_active = tab_info.is_active,
      })
    end

    table.insert(session.windows, window_info)
  end

  return session
end

local function restore_session(session)
  if not session or not session.windows or #session.windows == 0 then
    return false
  end

  for _, window_info in ipairs(session.windows) do
    local tabs = window_info.tabs or {}
    local first_tab = tabs[1]
    local spawn_opts = {
      workspace = window_info.workspace or "main",
    }

    if first_tab and first_tab.cwd then
      spawn_opts.cwd = first_tab.cwd
    end

    local tab, _, window = mux.spawn_window(spawn_opts)
    if first_tab and first_tab.title and first_tab.title ~= "" then
      tab:set_title(first_tab.title)
    end

    local active_tab = tab
    if first_tab and first_tab.is_active then
      active_tab = tab
    end

    for idx = 2, #tabs do
      local tab_info = tabs[idx]
      local tab_opts = {}
      if tab_info.cwd then
        tab_opts.cwd = tab_info.cwd
      end
      local new_tab = window:spawn_tab(tab_opts)
      if tab_info.title and tab_info.title ~= "" then
        new_tab:set_title(tab_info.title)
      end
      if tab_info.is_active then
        active_tab = new_tab
      end
    end

    if active_tab then
      active_tab:activate()
    end
  end

  return true
end

local function bootstrap_default_workspace()
  if #project_profiles == 0 then
    mux.spawn_window({})
    return
  end

  local primary = project_profiles[1]
  local workspace = primary.workspace or "main"
  local tab, _, window = mux.spawn_window({
    cwd = primary.cwd,
    workspace = workspace,
  })

  if primary.name then
    tab:set_title(primary.name)
  end

  for idx = 2, #project_profiles do
    local profile = project_profiles[idx]
    local new_tab = window:spawn_tab({ cwd = profile.cwd })
    if profile.name then
      new_tab:set_title(profile.name)
    end
  end
end

wezterm.on("mux-startup", function()
  local session = read_session()
  if session and restore_session(session) then
    return
  end

  bootstrap_default_workspace()
end)

wezterm.on("save-session", function(window, _)
  local session = capture_session()
  local ok = write_session(session)
  if ok then
    window:toast_notification("WezTerm", "Session saved", nil, 3000)
  else
    window:toast_notification("WezTerm", "Failed to save session", nil, 4000)
  end
end)

wezterm.on("restore-session", function(window, _)
  local session = read_session()
  if session and restore_session(session) then
    window:toast_notification("WezTerm", "Session restored", nil, 3000)
  else
    window:toast_notification("WezTerm", "No session found", nil, 4000)
  end
end)

wezterm.on("bell", function(window, pane)
  local now = os.time()
  wezterm.GLOBAL.last_bell = wezterm.GLOBAL.last_bell or 0
  if now - wezterm.GLOBAL.last_bell < 2 then
    return
  end

  wezterm.GLOBAL.last_bell = now
  if window:is_focused() then
    return
  end

  local title = pane and pane:get_title() or "Activity"
  window:toast_notification("WezTerm", "Bell: " .. title, nil, 4000)
end)

wezterm.on("user-var-changed", function(window, _, name, value)
  if name == "WEZTERM_NOTIFY" and value and value ~= "" then
    window:toast_notification("WezTerm", value, nil, 4000)
  end
end)

wezterm.on("update-status", function(window, pane)
  apply_window_overrides(window, pane)

  local project = project_label_for_pane(pane)
  local branch = git_branch_for_pane(pane)
  local parts = {}
  if project and project ~= "" then
    table.insert(parts, project)
  end
  if branch and branch ~= "" then
    table.insert(parts, "git:" .. branch)
  end

  local left = table.concat(parts, " | ")
  if left ~= "" then
    window:set_left_status(wezterm.format({ { Text = " " .. left .. " " } }))
  else
    window:set_left_status("")
  end
end)

wezterm.on("format-tab-title", function(tab)
  return tab_title_for_pane(tab)
end)

wezterm.on("update-right-status", function(window, pane)
  local cells = {}
  local function push(text, color)
    table.insert(cells, { Foreground = { Color = color } })
    table.insert(cells, { Text = text })
  end

  if window:leader_is_active() then
    push(" LDR ", "#e3c78a")
  end

  local key_table = window:active_key_table()
  if key_table then
    push(" " .. key_table:upper() .. " ", "#7aa2f7")
  end

  local workspace = window:active_workspace()
  if workspace and workspace ~= "" then
    push(" " .. workspace .. " ", "#7bd88f")
  end

  local branch = git_branch_for_pane(pane)
  if branch and branch ~= "" then
    push(" git:" .. branch .. " ", "#e3c78a")
  end

  local cwd = cwd_name(pane)
  if cwd ~= "" then
    push(" " .. cwd .. " ", "#9aa7b1")
  end

  local battery, on_battery = battery_status()
  if battery then
    local color = on_battery and "#e06c75" or "#7bd88f"
    push(" " .. battery .. " ", color)
  end

  local date = wezterm.strftime("%a %b %d %H:%M")
  push(" " .. date .. " ", "#c9d1d9")

  window:set_right_status(wezterm.format(cells))
end)

config.color_schemes = {
  ["UtilsScripts Dark"] = {
    background = "#0b0f14",
    foreground = "#d6dde5",
    cursor_bg = "#9ad0ff",
    cursor_border = "#9ad0ff",
    cursor_fg = "#0b0f14",
    selection_bg = "#1f2a37",
    selection_fg = "#d6dde5",
    ansi = {
      "#1b2028",
      "#e06c75",
      "#7bd88f",
      "#e3c78a",
      "#7aa2f7",
      "#b48ead",
      "#4cb7b5",
      "#cfd8e3",
    },
    brights = {
      "#2a313c",
      "#f08a92",
      "#8fe3a6",
      "#f0d9a6",
      "#8fb4ff",
      "#c4a1e3",
      "#60cfcf",
      "#e5ecf3",
    },
    tab_bar = {
      background = "#0b0f14",
      active_tab = { bg_color = "#1f2a37", fg_color = "#d6dde5", intensity = "Bold" },
      inactive_tab = { bg_color = "#0f141b", fg_color = "#9aa7b1" },
      inactive_tab_hover = { bg_color = "#1b222c", fg_color = "#d6dde5" },
      new_tab = { bg_color = "#0f141b", fg_color = "#9aa7b1" },
      new_tab_hover = { bg_color = "#1b222c", fg_color = "#d6dde5" },
    },
  },
  ["UtilsScripts Light"] = {
    background = "#f6f2e8",
    foreground = "#2c3640",
    cursor_bg = "#2b6cb0",
    cursor_border = "#2b6cb0",
    cursor_fg = "#f6f2e8",
    selection_bg = "#dfe7ef",
    selection_fg = "#2c3640",
    ansi = {
      "#333a45",
      "#d1495b",
      "#2f9e44",
      "#b77b00",
      "#2b6cb0",
      "#8b5fbf",
      "#14858c",
      "#f4efe6",
    },
    brights = {
      "#4a5560",
      "#e06a7c",
      "#3fb15c",
      "#c48a18",
      "#3c7cc4",
      "#9d73cf",
      "#1e9aa1",
      "#ffffff",
    },
    tab_bar = {
      background = "#f6f2e8",
      active_tab = { bg_color = "#dfe7ef", fg_color = "#2c3640", intensity = "Bold" },
      inactive_tab = { bg_color = "#eee7db", fg_color = "#6d7782" },
      inactive_tab_hover = { bg_color = "#e2dacc", fg_color = "#2c3640" },
      new_tab = { bg_color = "#eee7db", fg_color = "#6d7782" },
      new_tab_hover = { bg_color = "#e2dacc", fg_color = "#2c3640" },
    },
  },
}

config.font = wezterm.font_with_fallback({
  "FiraCode Nerd Font",
  "Fira Code",
  "JetBrainsMono Nerd Font",
  "Menlo",
})
config.font_size = 13.0
config.line_height = 1.05
config.cell_width = 1.0

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

config.window_padding = {
  left = 12,
  right = 12,
  top = 10,
  bottom = 8,
}

config.max_fps = 120
config.animation_fps = 60
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

config.window_background_opacity = 0.96
config.macos_window_background_blur = 18
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.8,
}

config.scrollback_lines = 20000
config.enable_scroll_bar = false
config.audible_bell = "Disabled"
config.default_prog = { "zsh", "-l" }
config.term = "xterm-256color"
config.launch_menu = build_launch_menu()
config.default_workspace = "main"
config.initial_cols = 130
config.initial_rows = 34
config.status_update_interval = 1000
config.adjust_window_size_when_changing_font_size = false
config.selection_word_boundary = " \t\n{}[]()\"'`,;:|=<>"

config.quick_select_patterns = {
  [[https?://[^\s]+]],
  [[\b[a-f0-9]{7,40}\b]],
  [[\b[A-Z]{2,10}-[0-9]{1,6}\b]],
  [[\b[A-Z]{2,10}#[0-9]{1,6}\b]],
  [[\b[\w./~-]+:[0-9]+\b]],
  [[\b[\w.-]+/[\w./-]+\b]],
}

local hyperlink_rules = wezterm.default_hyperlink_rules()
table.insert(hyperlink_rules, {
  regex = [[\b([A-Z]{2,10}-[0-9]{1,6})\b]],
  format = "https://jira.atlassian.com/browse/$1",
})
table.insert(hyperlink_rules, {
  regex = [[\b([A-Z]{2,10}#[0-9]{1,6})\b]],
  format = "https://github.com/search?q=$1&type=issues",
})
config.hyperlink_rules = hyperlink_rules

config.copy_on_select = true

config.leader = { key = "g", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
  { key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
  { key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
  { key = "f", mods = "CTRL|SHIFT", action = act.Search("CurrentSelectionOrEmptyString") },
  { key = "r", mods = "CTRL|SHIFT", action = act.ReloadConfiguration },
  { key = "r", mods = "SUPER", action = act.ReloadConfiguration },
  { key = "p", mods = "CTRL|SHIFT", action = act.ActivateCommandPalette },
  { key = "Enter", mods = "ALT", action = act.ToggleFullScreen },
  { key = "u", mods = "CTRL|SHIFT", action = act.CharSelect },
  { key = "y", mods = "CTRL|SHIFT", action = act.QuickSelect },

  { key = "\"", mods = "LEADER|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "%", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "|", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
  { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
  { key = ",", mods = "LEADER", action = prompt_tab_title() },
  { key = "S", mods = "LEADER|SHIFT", action = act.EmitEvent("save-session") },
  { key = "R", mods = "LEADER|SHIFT", action = act.EmitEvent("restore-session") },
  { key = "m", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "LAUNCH_MENU_ITEMS|FUZZY" }) },
  { key = "&", mods = "LEADER|SHIFT", action = act.CloseCurrentTab({ confirm = true }) },
  { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
  { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
  { key = "r", mods = "LEADER", action = act.ReloadConfiguration },
  { key = "r", mods = "LEADER|CTRL", action = act.ReloadConfiguration },
  { key = "s", mods = "LEADER", action = act.ShowTabNavigator },
  { key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "WORKSPACES" }) },
  { key = "[", mods = "LEADER", action = act.ActivateCopyMode },
  { key = "]", mods = "LEADER", action = act.PasteFrom("Clipboard") },
  { key = "/", mods = "LEADER", action = act.Search("CurrentSelectionOrEmptyString") },
  { key = "f", mods = "LEADER", action = act.QuickSelect },
  { key = "o", mods = "LEADER", action = act.OpenLinkAtMouseCursor },

  { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },

  { key = "H", mods = "LEADER", action = act.AdjustPaneSize({ "Left", 5 }) },
  { key = "J", mods = "LEADER", action = act.AdjustPaneSize({ "Down", 3 }) },
  { key = "K", mods = "LEADER", action = act.AdjustPaneSize({ "Up", 3 }) },
  { key = "L", mods = "LEADER", action = act.AdjustPaneSize({ "Right", 5 }) },
}

for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = act.ActivateTab(i - 1),
  })
end

config.key_tables = {
  copy_mode = {
    { key = "v", mods = "NONE", action = act.CopyMode("SetSelectionMode") },
    { key = "y", mods = "NONE", action = act.CopyTo("ClipboardAndPrimarySelection") },
    { key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
  },
}

return config
