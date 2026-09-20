<p align="center">
  <picture>
    <img src="cloche-logo/watermark.png" alt="Cloche OS Logo" height="80" />
  </picture>
</p>

<p align="center">
    <strong>Pro bootc Workstation</strong>
</p>

<p align="center">
  <strong>Cloche PRO Workstation</strong> is a bootc-based desktop image built on top of Cloche PRO, aimed at enterprise and power-user deployments that want a container-native workstation with the stability of CentOS Stream.
</p>

<p align="center">
  <a href="https://github.com/cloche-project/cloche-pro-workstation/actions/workflows/build.yml">
    <img src="https://github.com/cloche-project/cloche-pro-workstation/actions/workflows/build.yml/badge.svg" alt="Build Status" />
  </a>
  <a href="https://ghcr.io/cloche-project/cloche-pro-workstation-gnome">
    <img src="https://img.shields.io/badge/registry-GHCR-blue?logo=github" alt="GHCR Registry" />
  </a>
  <img src="https://img.shields.io/github/license/cloche-project/cloche-pro-workstation" alt="License" />
</p>

> [!NOTE]
> **Cloche PRO Workstation inherits directly from the [Cloche PRO](https://github.com/cloche-project/cloche-pro) base image.** It layers a full desktop environment on top via raw `dnf install` in the `containerfile` module — a different package-install mechanism from `cloche-standard` by design, since this image is `bootc`-deployed rather than `rpm-ostree`-deployed. See the workspace-root `CLAUDE.md` for why.

---

## Available Variants

| Image Name | Desktop Environment | Target Use Case |
|------------|---------------------|-----------------|
| `cloche-pro-workstation-gnome` | GNOME (Wayland native) | Enterprise/power-user workstation, minimalist desktop |
| `cloche-pro-workstation-plasma` | KDE Plasma | Enterprise/power-user workstation, highly customizable desktop |

---

## Core Desktop Architecture

| Component | Details |
|-----------|---------|
| **Base Layer** | Cloche PRO (`ghcr.io/cloche-project/cloche-pro:latest`) |
| **Deployment Model** | `bootc` — container image *is* the bootable OS |
| **App Delivery** | Flatpak (Flathub remote pre-configured) |
| **Package Source** | `@workstation`/`@KDE` groups plus the `cloche-gnome-defaults`/`cloche-kde-defaults` RPMs from the [`rpm-repo`](https://github.com/cloche-project/rpm-repo) Cloche Pro repository |

---

## Key Desktop Features

* **Bootc-Native:** The same container image built by CI is what boots on disk — updates and rollbacks go through `bootc`, not `rpm-ostree`.
* **Desktop Defaults via RPM:** KDE/GNOME theming, wallpapers, and shell defaults come from the `cloche-kde-defaults`/`cloche-gnome-defaults` packages, keeping desktop configuration in sync with the rest of the Cloche family.
* **Admin Tooling:** Ships Cockpit, Distrobox, and passwordless `bootc` access for the `wheel` group, geared towards fleet/enterprise management.
* **Flatpak-First Apps:** Flathub is pre-configured as a system remote for sandboxed user-space applications.

---

## Deployment & Installation

### Switching to Cloche PRO Workstation

`bootc` installations move between images with `bootc switch`, not `rpm-ostree rebase`:

```bash
# Example: switching to the GNOME variant
sudo bootc switch ghcr.io/cloche-project/cloche-pro-workstation-gnome:latest

# Or for the Plasma variant
sudo bootc switch ghcr.io/cloche-project/cloche-pro-workstation-plasma:latest
```

### Apply the change by rebooting:

```bash
systemctl reboot
```

---

## Verification & Security

Every desktop image build is signed via Sigstore Cosign against the repository's public verification key.

```bash
# Verify the specific desktop variant layer
cosign verify --key cosign.pub ghcr.io/cloche-project/cloche-pro-workstation-gnome:latest
```

## License & Acknowledgments

* Licensed under Apache 2.0
* Inherits core packaging from the `cloche-project/cloche-pro` base layer
* Powered by the BlueBuild framework and CentOS bootc images
