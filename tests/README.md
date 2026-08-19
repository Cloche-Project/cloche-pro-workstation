# cloche-pro-workstation tests

Checks the 7 known parity gaps vs. `cloche-standard`'s Plasma recipe (see the workspace-root
`CLAUDE.md`, "Known gaps: cloche-pro-workstation vs cloche-standard"). Every check here currently
expects the feature to be **absent** — these are gap-tracking tests, not a working feature suite.
`cloche-standard/tests/run.sh` runs the same 7 categories asserting presence, as the reference side.

Uses the shared harness — see [cloche-utils/testing/README.md](../../cloche-utils/testing/README.md)
for `test-lib.sh` details, local/CI usage, and the `CLOCHE_UTILS_DIR` env var.

Run: `./tests/run.sh [image-tag]` (`BUILD_METHOD=bluebuild`, builds `./recipes/cloche-pro-workstation-plasma.yml`).

## Checks

| Gap | Checks |
|---|---|
| 1. KDE skel files | `kactivitymanagerdrc`, `kglobalshortcutsrc`, `konsolerc`, `kscreenlockerrc` under `/etc/skel/.config/`; Konsole `Main.profile` under `/etc/skel/.local/share/konsole/` |
| 2. Dynamic KDE wallpaper | `images/` + `images-dark/` dirs under `/usr/share/wallpapers/*/contents/`; `DynamicMode=2` in wallpaper metadata |
| 3. GNOME CustomTransparent theme | `/usr/share/themes/CustomTransparent` dir + `gnome-shell.css` inside it |
| 4. rpm-repo packages | `cloche-common`, `cloche-kde-defaults`, `cloche-gnome-defaults`, `cloche-wallpapers-1` installed |
| 5. Display manager | `plasmalogin` system user exists; `plasmalogin.service` enabled in systemd presets |
| 6. Boot-speed masks | `NetworkManager-wait-online.service` masked (symlinked to `/dev/null`) |
| 7. plasma-discover exclusion | `plasma-discover` and `plasma-discover-notifier` both **not** installed |

As gaps get closed in the recipe, flip the corresponding check from expecting failure to expecting
success (mirroring how `cloche-standard`'s suite already asserts it).
