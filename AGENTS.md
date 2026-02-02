# Agent Instructions

This project uses **br** (beads_rust) for issue tracking. Run `br init` to get started.

**Note:** `br` is non-invasive and never executes git commands. After `br sync`, you must manually run `git add .beads/ && git commit`.

## Multi-agent coordination (Codex + br + Agent Mail + Clawdbot)

Treat this file as the **shared contract** between all AI agents working in this repo.

**At session start (every agent):**
1) Read `AGENTS.md` first.
2) Run `br ready` and pick **one** issue (or confirm the human assigned you one).
3) Use the **br issue id** as the single identifier everywhere:
   - Mail `thread_id`: `br-<id>` (or the issue id if it already includes a prefix)
   - Message subject prefix: `[br-<id>]`
   - File reservation reason: `br-<id>`
   - (Optional) commit message includes `br-<id>` for traceability
4) Before editing, take **exclusive file reservations** for the smallest glob that covers your change (release when done).
5) Post a short start/progress/done update in the Mail thread so other agents can see what changed.

**Environment conventions (recommended):**
- Set `AGENT_NAME` (unique, stable): e.g. `export AGENT_NAME=codex-main` / `codex-ui` / `mail-agent`.
- Use the repo root absolute path as the Mail `project_key`.

This keeps task status in **br**, coordination/audit trail in **Agent Mail**, and prevents agents from editing the same files at once.

### Clawdbot “control tower” conventions (Option B)

Clawdbot is an external orchestrator that can:
- read/update this file
- read repo files and run commands (when pointed at a repo)
- coordinate multiple agents by consuming **Agent Mail threads** + a small set of **drop files**

To coordinate cleanly with Clawdbot, follow these conventions.

**1) One canonical thread per br issue**
- Thread id: `br-<id>`
- Subject prefix: `[br-<id>]`
- All decisions, blockers, and handoffs live in that thread.

**2) Handoff message template (post in the Mail thread)**
When you want Clawdbot to pick up / review / merge / run tests, post a message like:
- `REQUEST: <what you want>` (review / run tests / resolve conflict / write docs / etc.)
- `CONTEXT: <1–3 bullets>`
- `CHANGES: <files touched + what changed>`
- `COMMANDS TO RUN: <copy/paste>`
- `RISKS: <what might break>`
- `NEXT: <what remains>`

**3) Drop files (optional but very effective)**
If Mail isn’t available to one of the agents, use these lightweight files:
- `./.agent/STATUS.md` — current state + what’s next (overwrite freely)
- `./.agent/REQUEST.md` — explicit request for Clawdbot (overwrite; treat as a queue of 1)
- `./.agent/DECISIONS.md` — append-only, short rationale for non-obvious choices

Format for `REQUEST.md`:
- `br: br-123`
- `request: run tests + propose fix for failing case`
- `owner: codex-ui`
- `paths: src/ui/**`

**4) File reservations still apply**
Even if Clawdbot isn’t editing code directly, still reserve when you edit. If you want Clawdbot to edit too, explicitly say so in-thread and release the reservation first.

**5) Escalation rule**
If you’re blocked >15 minutes or unsure, post a Mail update:
- `BLOCKED:` + what you tried + what you need decided.

## Quick Reference

```bash
br ready              # Find available work
br show <id>          # View issue details
br update <id> --status in_progress  # Claim work
br close <id>         # Complete work
br sync              # Sync with git
git add .beads/
git commit -m "sync beads"
```

## Landing the Plane (Session Completion)

**When ending a work session**, you MUST complete ALL steps below. Work is NOT complete until `git push` succeeds.

**MANDATORY WORKFLOW:**

1. **File issues for remaining work** - Create issues for anything that needs follow-up
2. **Run quality gates** (if code changed) - Tests, linters, builds
3. **Commit code changes** (if any) - `git add <paths> && git commit -m "<message>"`
4. **Update issue status** - Close finished work, update in-progress items
5. **PUSH TO REMOTE** - This is MANDATORY:
   ```bash
   git pull --rebase
   br sync --flush-only
   git add .beads/
   git commit -m "sync beads"
   git push
   git status  # MUST show "up to date with origin"
   ```
6. **Clean up** - Clear stashes, prune remote branches
7. **Verify** - All changes committed AND pushed
8. **Hand off** - Provide context for next session

**CRITICAL RULES:**
- Work is NOT complete until `git push` succeeds
- NEVER stop before pushing - that leaves work stranded locally
- NEVER say "ready to push when you are" - YOU must push
- If push fails, resolve and retry until it succeeds

Use 'br' for task tracking and planning. Always query 'br ready' before starting work.

## MCP Agent Mail: coordination for multi-agent workflows

What it is
- A mail-like layer that lets coding agents coordinate asynchronously via MCP tools and resources.
- Provides identities, inbox/outbox, searchable threads, and advisory file reservations, with human-auditable artifacts in Git.

Why it's useful
- Prevents agents from stepping on each other with explicit file reservations (leases) for files/globs.
- Keeps communication out of your token budget by storing messages in a per-project archive.
- Offers quick reads (`resource://inbox/...`, `resource://thread/...`) and macros that bundle common flows.

How to use effectively
1) Same repository
   - Register an identity: call `ensure_project`, then `register_agent` using this repo's absolute path as `project_key`.
   - Reserve files before you edit: `file_reservation_paths(project_key, agent_name, ["src/**"], ttl_seconds=3600, exclusive=true)` to signal intent and avoid conflict.
   - Communicate with threads: use `send_message(..., thread_id="FEAT-123")`; check inbox with `fetch_inbox` and acknowledge with `acknowledge_message`.
   - Read fast: `resource://inbox/{Agent}?project=<abs-path>&limit=20` or `resource://thread/{id}?project=<abs-path>&include_bodies=true`.
   - Tip: set `AGENT_NAME` in your environment so the pre-commit guard can block commits that conflict with others' active exclusive file reservations.

2) Across different repos in one project (e.g., Next.js frontend + FastAPI backend)
   - Option A (single project bus): register both sides under the same `project_key` (shared key/path). Keep reservation patterns specific (e.g., `frontend/**` vs `backend/**`).
   - Option B (separate projects): each repo has its own `project_key`; use `macro_contact_handshake` or `request_contact`/`respond_contact` to link agents, then message directly. Keep a shared `thread_id` (e.g., ticket key) across repos for clean summaries/audits.

Macros vs granular tools
- Prefer macros when you want speed or are on a smaller model: `macro_start_session`, `macro_prepare_thread`, `macro_file_reservation_cycle`, `macro_contact_handshake`.
- Use granular tools when you need control: `register_agent`, `file_reservation_paths`, `send_message`, `fetch_inbox`, `acknowledge_message`.

Common pitfalls
- "from_agent not registered": always `register_agent` in the correct `project_key` first.
- "FILE_RESERVATION_CONFLICT": adjust patterns, wait for expiry, or use a non-exclusive reservation when appropriate.
- Auth errors: if JWT+JWKS is enabled, include a bearer token with a `kid` that matches server JWKS; static bearer is used only when JWT is disabled.

## Parallel work (sub-agents)

Use sub-agents when tasks can be split cleanly (e.g., UI + backend, docs + code, or broad refactors).

Guidelines
- **Spawn deliberately**: create a sub-agent with a clear task boundary and expected output.
- **Register + reserve**: the sub-agent should `register_agent` and take file reservations before editing.
- **Single thread per issue**: keep updates in the same Mail `thread_id` (e.g., `br-123`) to preserve audit trail.
- **No direct git**: sub-agents should not push; the primary agent lands changes.

Suggested flow
1) Primary agent creates the plan and sends a kickoff Mail message.
2) Spawn sub-agents with a scoped task (e.g., “Update UI badges”).
3) Each sub-agent reports back via Agent Mail with changes + files touched.
4) Primary agent integrates, runs quality gates, commits, and pushes.


## Integrating with br (beads_rust) (dependency-aware task planning)

**Note:** `br` is non-invasive and never executes git commands. After `br sync --flush-only`, you must manually run `git add .beads/ && git commit`.

br provides a lightweight, dependency-aware issue database and a CLI (`br`) for selecting "ready work," setting priorities, and tracking status. It complements MCP Agent Mail's messaging, audit trail, and file-reservation signals.

Recommended conventions
- **Single source of truth**: Use **br** for task status/priority/dependencies; use **Agent Mail** for conversation, decisions, and attachments (audit).
- **Shared identifiers**: Use the br issue id (e.g., `br-123`) as the Mail `thread_id` and prefix message subjects with `[br-123]`.
- **Reservations**: When starting a `br-###` task, call `file_reservation_paths(...)` for the affected paths; include the issue id in the `reason` and release on completion.

Typical flow (agents)
1) **Pick ready work** (br)
   - `br ready --json` → choose one item (highest priority, no blockers)
2) **Reserve edit surface** (Mail)
   - `file_reservation_paths(project_key, agent_name, ["src/**"], ttl_seconds=3600, exclusive=true, reason="br-123")`
3) **Announce start** (Mail)
   - `send_message(..., thread_id="br-123", subject="[br-123] Start: <short title>", ack_required=true)`
4) **Work and update**
   - Reply in-thread with progress and attach artifacts/images; keep the discussion in one thread per issue id
5) **Complete and release**
   - `br close br-123 --reason "Completed"` (br is status authority)
   - `release_file_reservations(project_key, agent_name, paths=["src/**"])`
   - Final Mail reply: `[br-123] Completed` with summary and links

Mapping cheat-sheet
- **Mail `thread_id`** ↔ `br-###`
- **Mail subject**: `[br-###] …`
- **File reservation `reason`**: `br-###`
- **Commit messages (optional)**: include `br-###` for traceability

Event mirroring (optional automation)
- On `br update --status blocked`, send a high-importance Mail message in thread `br-###` describing the blocker.
- On Mail "ACK overdue" for a critical decision, add a br label (e.g., `needs-ack`) or bump priority to surface it in `br ready`.

Pitfalls to avoid
- Don't create or manage tasks in Mail; treat br as the single task queue.
- Always include `br-###` in message `thread_id` to avoid ID drift across tools.
