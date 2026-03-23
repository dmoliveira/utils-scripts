# Rectangle

This cheat sheet documents a practical Rectangle layout for a full-size keyboard with a numpad.

## Base layer: `cmd+alt`

These bindings keep the numpad as the primary spatial layer.

| Keys | Action |
| --- | --- |
| `4` | `moveLeft` |
| `6` | `moveRight` |
| `7` | `topLeftSixth` |
| `8` | `topCenterSixth` |
| `9` | `topRightSixth` |
| `1` | `bottomLeftSixth` |
| `2` | `bottomCenterSixth` |
| `3` | `bottomRightSixth` |

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

## Nav-cluster layer: `ctrl+alt+shift`

This companion layer provides larger shapes and reset actions without changing the numpad muscle memory.

| Keys | Action |
| --- | --- |
| `Insert` | `leftHalf` |
| `Home` | `topHalf` |
| `Page Up` | `maximize` |
| `Delete` | `rightHalf` |
| `End` | `bottomHalf` |
| `Page Down` | `center` |

## Notes

- Keep the numpad base layer stable; add new shapes on other keys instead of replacing the main layout.
- For exact 3x3 placement, prefer Rectangle `ninth` actions over `third` actions.
- If a shortcut does not trigger, verify it in Rectangle's shortcut UI because some keyboard firmware remaps numpad chords.
