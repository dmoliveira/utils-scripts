# Rectangle

This cheat sheet documents a practical Rectangle layout for a full-size keyboard with a numpad.

## Base layer: `ctrl+alt`

These bindings keep the numpad as the primary spatial layer, with sixths on the corners and large-window actions on the middle row.

| Keys | Action |
| --- | --- |
| `4` | `leftHalf` |
| `5` | `center` |
| `6` | `rightHalf` |
| `7` | `topLeftSixth` |
| `8` | `topCenterSixth` |
| `9` | `topRightSixth` |
| `1` | `bottomLeftSixth` |
| `2` | `bottomCenterSixth` |
| `3` | `bottomRightSixth` |
| `0` | `maximize` |
| `.` | `restore` |

## Grid layer: `ctrl+alt+shift`

These bindings use Rectangle's 3x3 `ninth` actions, so the numpad behaves like a literal screen grid.

| Keys | Action |
| --- | --- |
| `7` | `topLeftNinth` |
| `8` | `topCenterNinth` |
| `9` | `topRightNinth` |
| `4` | `middleLeftNinth` |
| `5` | `middleCenterNinth` |
| `6` | `middleRightNinth` |
| `1` | `bottomLeftNinth` |
| `2` | `bottomCenterNinth` |
| `3` | `bottomRightNinth` |

## Notes

- Keep the numpad base layer stable; use `ctrl+alt` for everyday layout moves and `ctrl+alt+shift` for exact 33% placement.
- For exact 3x3 placement, prefer Rectangle `ninth` actions over `third` actions.
- `4 5 6` and `0 .` stay on the base layer so the most common large-window actions are still one chord away.
- If a shortcut does not trigger, verify it in Rectangle's shortcut UI because some keyboard firmware remaps numpad chords.
