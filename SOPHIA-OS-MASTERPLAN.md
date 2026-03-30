# SOPHIA OS — Master Plan

**Versi Dokumen:** 1.0
**Tanggal:** 30 Maret 2026
**Penulis:** Khalifardy Miqdarsah (Miko)
**Proyek:** IDEASOPHIA — Sophia OS

---

## 1. Visi & Misi

### Visi
Sophia OS adalah distribusi Linux berbasis Debian yang dirancang khusus untuk komunitas sains, riset, dan pendidikan di Indonesia. Dengan filosofi **"Ideas Grow Like Leaves Under Sunlight"**, Sophia OS menjadi perpanjangan ekosistem IDEASOPHIA ke level sistem operasi — memberikan lingkungan kerja yang siap pakai untuk peneliti, mahasiswa, dan pengembang di bidang astronomi, kecerdasan buatan, dan komputasi ilmiah.

### Misi

- Menyediakan sistem operasi yang **siap riset** dengan tools sains pre-installed dan terkonfigurasi
- Mewakili Indonesia di komunitas open source global melalui distro Linux berkualitas dengan **lokalisasi Bahasa Indonesia yang lengkap**
- Mengintegrasikan ekosistem IDEASOPHIA (platform edukasi, lab, dan tools) langsung dari desktop
- Membangun komunitas riset open source Indonesia yang aktif dan kolaboratif

---

## 2. Identitas & Branding

### Nama & Tagline
- **Nama:** Sophia OS
- **Tagline:** "Your Research Companion" / "Teman Risetmu"
- **Maskot:** Sophia the Owl (maskot IDEASOPHIA)
- **Parent Brand:** IDEASOPHIA

### Sistem Versioning — Seri Gunung Berapi Indonesia
Setiap major release dinamai dengan gunung berapi Indonesia, merepresentasikan kekuatan dan keunikan nusantara:

| Versi | Codename | Status |
|-------|----------|--------|
| 1.0 | **Merapi** | Target rilis pertama |
| 2.0 | **Semeru** | Rencana |
| 3.0 | **Krakatau** | Rencana |
| 4.0 | **Rinjani** | Rencana |
| 5.0 | **Bromo** | Rencana |

### Design System
Mengikuti design system IDEASOPHIA yang sudah ada:

- **Background gelap:** `#2b2b2b`
- **Accent hijau utama:** `#37a749`
- **Accent hijau muda:** `#83c441`
- **Accent kuning-hijau:** `#dee21d`
- **Teks cream:** `#f4f6d2`
- **Font utama:** Source Code Pro
- **Font UI:** Noto Sans (untuk dukungan multi-bahasa)

---

## 3. Spesifikasi Teknis

### Base System
- **Base:** Debian Stable (Bookworm/Trixie)
- **Arsitektur:** amd64 (utama), arm64 (masa depan — Raspberry Pi support)
- **Desktop Environment:** KDE Plasma 5/6
- **Display Manager:** SDDM
- **Init System:** systemd
- **Filesystem:** ext4 (default), btrfs (opsi)
- **Build Tool:** `debian-live-build`

### Kebutuhan Sistem Minimum
| Komponen | Minimum | Rekomendasi |
|----------|---------|-------------|
| CPU | 2 core, 64-bit | 4+ core |
| RAM | 4 GB | 8-16 GB |
| Storage | 30 GB | 100+ GB (untuk dataset) |
| GPU | Integrated | NVIDIA (CUDA support) |

### Kernel
- Kernel Debian stable sebagai default
- Opsi kernel `linux-headers` pre-installed untuk kompilasi driver
- NVIDIA driver support via `nvidia-driver` package (non-free)
- DKMS pre-configured untuk kernel module management

---

## 4. Arsitektur Sistem

### 4.1 Build System

```
sophia-os/
├── build/                        # Output build (ISO, logs)
├── config/                       # live-build configuration
│   ├── archives/                 # Repository tambahan (NVIDIA, VS Code, Docker)
│   ├── bootloaders/              # GRUB/isolinux config + branding
│   ├── hooks/                    # Build hooks (pre/post install scripts)
│   │   ├── live/                 # Hooks untuk live session
│   │   └── normal/               # Hooks untuk installed system
│   ├── includes.chroot/          # File yang di-copy ke filesystem
│   │   ├── etc/                  # System config files
│   │   ├── usr/share/            # Themes, wallpapers, icons
│   │   └── opt/sophia/           # Sophia OS custom tools
│   ├── package-lists/            # Daftar paket per kategori
│   │   ├── base.list.chroot      # Paket dasar
│   │   ├── desktop.list.chroot   # KDE Plasma + apps
│   │   ├── science.list.chroot   # Tools sains
│   │   ├── astronomy.list.chroot # Tools astronomi
│   │   ├── ml-ai.list.chroot     # ML/AI packages
│   │   ├── dev.list.chroot       # Development tools
│   │   └── locale.list.chroot    # Localization packages
│   └── preseed/                  # Debian installer preseed
├── branding/                     # Aset visual (logo, wallpaper, splash)
├── themes/                       # KDE themes source
│   ├── plasma-theme/             # Plasma desktop theme
│   ├── color-scheme/             # Color scheme (.colors)
│   ├── sddm-theme/              # Login screen theme
│   ├── splash/                   # Splash screen
│   ├── konsole/                  # Terminal profile
│   └── icons/                    # Icon theme (jika custom)
├── sophia-tools/                 # Custom applications
│   ├── sophia-welcome/           # Welcome app
│   ├── sophia-hub/               # IDEASOPHIA integration app
│   └── sophia-toolkit/           # Research toolkit launcher
├── scripts/                      # Build & utility scripts
│   ├── build.sh                  # Main build script
│   ├── clean.sh                  # Clean build artifacts
│   └── test-vm.sh                # Launch QEMU test VM
├── docs/                         # Dokumentasi
├── SOPHIA-OS-MASTERPLAN.md       # Dokumen ini
└── README.md                     # Panduan singkat
```

### 4.2 Lapisan Sistem (System Layers)

```
┌─────────────────────────────────────────────┐
│           Sophia Desktop Experience          │  ← Custom KDE theme, wallpaper,
│         (Plasma Theme + Sophia Tools)        │    welcome app, hub
├─────────────────────────────────────────────┤
│         Scientific Application Layer         │  ← Stellarium, Jupyter, PyTorch,
│     (Astronomi / ML-AI / Komputasi Ilmiah)   │    Astropy, R, Octave, LaTeX
├─────────────────────────────────────────────┤
│          Development Environment             │  ← Docker, Git, VS Code, Python,
│        (Tools pengembangan & DevOps)         │    Node.js, GCC, CMake
├─────────────────────────────────────────────┤
│              KDE Plasma Desktop              │  ← Desktop environment + SDDM
├─────────────────────────────────────────────┤
│           Debian Base System                 │  ← Kernel, systemd, apt, drivers
│        (Bookworm/Trixie + non-free)          │    NVIDIA support
└─────────────────────────────────────────────┘
```

---

## 5. Fitur Utama

### 5.1 Custom Sophia Desktop Experience

**Sophia KDE Theme** — tema KDE Plasma lengkap dengan identitas IDEASOPHIA:

| Komponen | Deskripsi |
|----------|-----------|
| **Plasma Theme** | Panel, widget, dan dialog dengan warna hijau-gelap IDEASOPHIA |
| **Color Scheme** | `sophia-dark.colors` dan `sophia-light.colors` |
| **SDDM Theme** | Login screen dengan maskot Sophia the Owl dan branding |
| **Splash Screen** | Animasi logo IDEASOPHIA saat boot |
| **Wallpapers** | Set wallpaper eksklusif Sophia OS (dark & light variants) |
| **Konsole Profile** | Terminal dengan color scheme Sophia (hijau-on-gelap) |
| **Plymouth Theme** | Boot splash sebelum desktop muncul |
| **GRUB Theme** | Boot loader menu dengan branding Sophia OS |
| **Cursor Theme** | Kursor mouse custom (opsional) |

**Sophia Welcome App** — aplikasi selamat datang yang muncul saat pertama kali login:
- Pengenalan fitur Sophia OS
- Quick setup wizard (locale, timezone, NVIDIA driver)
- Link ke dokumentasi dan komunitas
- Toggle install paket opsional (full astronomy suite, ML toolkit, dll.)

### 5.2 Scientific Tools Bundle

#### Astronomi
| Paket | Fungsi |
|-------|--------|
| `stellarium` | Planetarium 3D |
| `kstars` | Planetarium KDE + kontrol teleskop |
| `python3-astropy` | Library astronomi Python |
| `saods9` | FITS image viewer |
| `python3-astroquery` | Akses katalog astronomi online |
| `python3-photutils` | Fotometri |
| `python3-specutils` | Analisis spektrum |
| `python3-ccdproc` | Pengolahan citra CCD |
| `iraf` | Image Reduction and Analysis Facility |
| `python3-pyraf` | Python interface untuk IRAF |
| `astrometry.net` | Plate solving |
| `sextractor` | Source extraction |

#### Machine Learning & AI
| Paket | Fungsi |
|-------|--------|
| `python3-torch` | PyTorch (deep learning) |
| `python3-tensorflow` | TensorFlow |
| `jupyter-notebook` | Jupyter Notebook |
| `jupyterlab` | JupyterLab |
| `python3-sklearn` | scikit-learn |
| `python3-pandas` | Data analysis |
| `python3-numpy` | Numerical computing |
| `python3-matplotlib` | Plotting |
| `python3-seaborn` | Statistical visualization |
| `python3-opencv` | Computer vision |

#### Komputasi Ilmiah
| Paket | Fungsi |
|-------|--------|
| `sagemath` | Computer algebra system |
| `octave` | MATLAB-compatible computing |
| `r-base` | Bahasa statistik R |
| `texlive-full` | LaTeX (penulisan paper) |
| `gnuplot` | Data plotting |
| `python3-sympy` | Symbolic math |
| `python3-scipy` | Scientific Python |
| `python3-xarray` | Labeled arrays |
| `paraview` | Visualisasi 3D |

#### Development
| Paket | Fungsi |
|-------|--------|
| `docker.io` | Containerization |
| `docker-compose` | Container orchestration |
| `git` | Version control |
| `code` | VS Code (via repo Microsoft) |
| `python3` + `python3-pip` + `python3-venv` | Python ecosystem |
| `nodejs` + `npm` | JavaScript runtime |
| `gcc` + `g++` + `make` + `cmake` | C/C++ toolchain |
| `neovim` | Text editor |
| `tmux` | Terminal multiplexer |
| `htop` | System monitor |
| `ripgrep` | Fast search |
| `curl` + `wget` + `jq` | CLI utilities |

### 5.3 IDEASOPHIA Ecosystem Integration

**Sophia Hub** — aplikasi desktop untuk integrasi dengan ekosistem IDEASOPHIA:

- **Quick Access Panel:** Shortcut ke ideasophia.com, Sophia's Nest, dan IDEASOPHIA Labs
- **Research Dashboard:** Widget KDE Plasma untuk memonitor progres riset dari platform IDEASOPHIA
- **Content Sync:** (masa depan) Sinkronisasi catatan riset antara OS dan platform web
- **Sophia Bookmarks:** Kumpulan bookmark browser ke resource edukasi (OpenStax, MIT OCW, arXiv, dll.)

**Pre-configured Browser Profile:**
- Bookmarks bar berisi link ke resource sains dan edukasi
- Extension yang direkomendasikan: Zotero, Dark Reader, uBlock Origin

### 5.4 Indonesian-first Localization

**Paket Lokalisasi:**
- `language-pack-id` — Base language support
- `language-pack-kde-id` — Terjemahan KDE Plasma
- `hunspell-id` — Spell checker Bahasa Indonesia
- `libreoffice-l10n-id` — LibreOffice terjemahan
- `firefox-locale-id` — Firefox Bahasa Indonesia
- Font: `fonts-noto`, `fonts-noto-cjk` (untuk dukungan Unicode lengkap)

**Konfigurasi Default:**
- Locale: `id_ID.UTF-8`
- Timezone: `Asia/Jakarta` (dengan opsi pilih WIB/WITA/WIT saat install)
- Keyboard: Standard QWERTY (layout US/ID)
- Format tanggal: DD/MM/YYYY
- Dokumentasi sistem dalam Bahasa Indonesia

**Catatan:** Sistem mendukung dual-language (ID + EN). User bisa switch bahasa kapan saja melalui System Settings.

---

## 6. Sophia Custom Applications

### 6.1 sophia-welcome

**Teknologi:** Python + PyQt6 / Qt Quick (QML)
**Fungsi:** First-boot welcome wizard

Fitur:
- Halaman pengenalan Sophia OS dengan maskot
- Pilihan bahasa (Indonesia / English)
- Setup timezone (WIB/WITA/WIT)
- Deteksi dan install NVIDIA driver (jika GPU terdeteksi)
- Pilihan install paket tambahan (full astronomy suite, ML toolkit, dll.)
- Link ke komunitas dan dokumentasi
- Opsi "Jangan tampilkan lagi"

### 6.2 sophia-hub

**Teknologi:** Python + PyQt6
**Fungsi:** Pusat integrasi IDEASOPHIA

Fitur:
- Dashboard ringkasan (cuaca, jadwal observasi astronomi malam ini)
- Quick launch untuk tools sains populer (Stellarium, Jupyter, dll.)
- Akses cepat ke ideasophia.com
- News feed dari blog IDEASOPHIA
- Daftar keyboard shortcuts Sophia OS

### 6.3 sophia-toolkit

**Teknologi:** Shell scripts + Python
**Fungsi:** CLI toolkit untuk manajemen environment riset

Fitur:
- `sophia-env create astro` — Buat Python virtual environment dengan paket astronomi
- `sophia-env create ml` — Buat environment ML/AI
- `sophia-env create datascience` — Buat environment data science
- `sophia-update` — Update semua paket sains
- `sophia-backup` — Backup konfigurasi dan data riset
- `sophia-gpu` — Cek status GPU dan CUDA

---

## 7. Edisi / Variant

Sophia OS akan dirilis dalam beberapa edisi untuk memenuhi kebutuhan berbeda:

### Edisi Utama

| Edisi | Target | Ukuran ISO (est.) | Deskripsi |
|-------|--------|-------------------|-----------|
| **Sophia OS Full** | Peneliti & Developer | ~6-8 GB | Semua tools sains, ML, astronomi, dev tools |
| **Sophia OS Lite** | Pelajar & Laptop ringan | ~3-4 GB | KDE Plasma + tools dasar + Python scientific stack |
| **Sophia OS Astro** | Astronom amatir & profesional | ~5-6 GB | Fokus tools astronomi + teleskop control |

### Edisi Masa Depan
- **Sophia OS Server** — Headless untuk HPC cluster dan compute nodes
- **Sophia OS Pi** — ARM64 untuk Raspberry Pi (remote observatory, edge computing)

---

## 8. Roadmap Pengembangan

### Fase 1: Foundation (Bulan 1-2)
- [x] Branding & identitas visual
- [ ] Setup repository Git untuk proyek
- [ ] Inisialisasi live-build configuration
- [ ] Definisi package lists per kategori
- [ ] Build ISO minimal pertama (Debian + KDE, tanpa customization)
- [ ] Test boot di QEMU/VirtualBox

### Fase 2: Theming & Branding (Bulan 3-4)
- [ ] Desain dan implementasi Plasma theme (dark + light)
- [ ] Desain SDDM login theme
- [ ] Desain Plymouth boot splash
- [ ] Desain GRUB theme
- [ ] Buat set wallpaper Sophia OS
- [ ] Buat Konsole color scheme
- [ ] Buat KDE color scheme (.colors file)

### Fase 3: Scientific Stack (Bulan 4-5)
- [ ] Integrasi paket astronomi
- [ ] Integrasi paket ML/AI
- [ ] Integrasi paket komputasi ilmiah
- [ ] Integrasi development tools
- [ ] Testing kompatibilitas antar paket
- [ ] Optimasi ukuran ISO

### Fase 4: Custom Applications (Bulan 5-7)
- [ ] Pengembangan sophia-welcome
- [ ] Pengembangan sophia-hub
- [ ] Pengembangan sophia-toolkit (CLI)
- [ ] Pengembangan Plasma widget IDEASOPHIA
- [ ] Integrasi semua custom apps ke ISO

### Fase 5: Localization & Polish (Bulan 7-8)
- [ ] Lokalisasi Bahasa Indonesia lengkap
- [ ] Penulisan dokumentasi (ID + EN)
- [ ] Pre-configured browser bookmarks
- [ ] Default desktop layout optimization
- [ ] Bug fixing dan stabilisasi

### Fase 6: Testing & Release (Bulan 8-10)
- [ ] Alpha testing internal
- [ ] Beta release ke komunitas terbatas
- [ ] Bug fixes berdasarkan feedback
- [ ] Penulisan release notes
- [ ] Build final ISO
- [ ] **Rilis Sophia OS v1.0 "Merapi"**
- [ ] Upload ISO ke SourceForge / GitHub Releases
- [ ] Pengumuman di blog IDEASOPHIA

### Fase 7: Post-Release (Ongoing)
- [ ] Setup update repository (apt repo)
- [ ] Community building (forum, Telegram/Discord)
- [ ] Mulai perencanaan v2.0 "Semeru"
- [ ] Kontribusi terjemahan ke upstream KDE

---

## 9. Strategi Distribusi

### Hosting ISO
- **GitHub Releases** — Primary download
- **SourceForge** — Mirror dan statistik download
- **IDEASOPHIA CDN** — Mirror di ideasophia.com/sophia-os

### Update Repository
- Custom apt repository di-host di server IDEASOPHIA
- Berisi: sophia-welcome, sophia-hub, sophia-toolkit, tema, dan konfigurasi
- User menambah repo via: `sudo add-apt-repository sophia-os`

### Dokumentasi
- **Website:** sophiaos.ideasophia.com (subdomain)
- **Wiki:** GitHub Wiki atau GitBook
- **Bahasa:** Indonesia (utama) + English

---

## 10. Pertimbangan Teknis

### Manajemen Ukuran ISO
- Gunakan metapackage approach — paket besar (texlive-full, sagemath) sebagai opsional
- Edisi Lite tidak include texlive-full dan sagemath
- Kompresi squashfs dengan xz untuk ukuran ISO lebih kecil

### NVIDIA GPU Support
- Include `nvidia-detect` untuk auto-detect GPU
- Driver tersedia via non-free repository (sudah dikonfigurasi)
- CUDA toolkit sebagai paket opsional (install via sophia-welcome)
- Fallback ke nouveau driver jika NVIDIA driver gagal

### Keamanan
- UFW (Uncomplicated Firewall) pre-installed dan enabled
- Automatic security updates via `unattended-upgrades`
- AppArmor enabled by default
- Secure boot support (signed kernel)

### Reproducible Builds
- Semua konfigurasi build di-track di Git
- CI/CD pipeline (GitHub Actions) untuk automated ISO build
- Version pinning untuk paket kritis
- Build script idempoten (bisa diulang dengan hasil sama)

---

## 11. Komunitas & Kontribusi

### Saluran Komunitas
- **GitHub:** Repository utama untuk kode, issues, dan PR
- **Telegram Group:** Diskusi informal komunitas Indonesia
- **Discord Server:** Diskusi teknis dan support
- **Forum IDEASOPHIA:** Kategori khusus Sophia OS

### Panduan Kontribusi
- Dokumentasi `CONTRIBUTING.md` dalam Bahasa Indonesia dan English
- Code of Conduct yang inklusif
- Label issues: `good-first-issue`, `help-wanted`, `astronomy`, `theming`, dll.
- Peluang kontribusi non-teknis: terjemahan, dokumentasi, testing, desain wallpaper

### Lisensi
- **ISO/Distro:** GPL v3 (mengikuti Debian)
- **Custom Tools (sophia-*):** GPL v3
- **Artwork & Branding:** CC BY-SA 4.0
- **Dokumentasi:** CC BY-SA 4.0

---

## 12. Inspirasi & Referensi

- **Pop!_OS** — Pendekatan theming dan developer experience
- **Fedora Scientific Spin** — Kurasi paket sains
- **KDE Neon** — Pendekatan KDE Plasma cutting-edge
- **Ubuntu Studio** — Pendekatan edisi khusus dengan workflow spesifik
- **Manjaro** — User-friendly Arch, welcome app yang bagus
- **Linux Mint** — Polish dan perhatian ke detail user experience

---

## Lampiran A: Daftar Lengkap Package Lists

### base.list.chroot
```
linux-image-amd64
firmware-linux
firmware-linux-nonfree
sudo
bash-completion
locales
console-setup
network-manager
wpasupplicant
bluetooth
pulseaudio
pipewire
```

### desktop.list.chroot
```
kde-plasma-desktop
sddm
plasma-workspace
dolphin
konsole
kate
ark
spectacle
gwenview
okular
kcalc
kde-config-sddm
plasma-nm
plasma-pa
powerdevil
bluedevil
breeze
breeze-gtk-theme
kde-spectacle
kscreen
```

### science.list.chroot
```
python3
python3-pip
python3-venv
python3-numpy
python3-scipy
python3-matplotlib
python3-pandas
python3-sympy
python3-sklearn
jupyter-notebook
jupyterlab
gnuplot
octave
r-base
```

### astronomy.list.chroot
```
stellarium
kstars
python3-astropy
python3-photutils
python3-specutils
python3-ccdproc
python3-astroquery
```

### ml-ai.list.chroot
```
python3-torch
python3-torchvision
python3-tensorflow
python3-keras
python3-opencv
python3-seaborn
python3-plotly
```

### dev.list.chroot
```
git
git-lfs
docker.io
docker-compose
build-essential
cmake
nodejs
npm
neovim
tmux
htop
ripgrep
curl
wget
jq
ssh
rsync
```

### locale.list.chroot
```
language-pack-id
language-pack-kde-id
hunspell-id
libreoffice-l10n-id
firefox-locale-id
fonts-noto
fonts-noto-cjk
fonts-noto-mono
```

---

*Dokumen ini akan terus diperbarui seiring perkembangan proyek Sophia OS.*

**IDEASOPHIA — Ideas Grow Like Leaves Under Sunlight**
