# Sophia OS

**Your Research Companion — Teman Risetmu**

Sophia OS adalah distribusi Linux berbasis Debian dengan desktop KDE Plasma, dirancang khusus untuk sains, riset, dan pendidikan. Bagian dari ekosistem [IDEASOPHIA](https://ideasophia.com).

## Fitur Utama

- **Scientific Tools Pre-installed** — Stellarium, Astropy, Jupyter, PyTorch, R, Octave, LaTeX, dan puluhan tools sains lainnya
- **Custom Sophia Desktop** — Tema KDE Plasma eksklusif dengan identitas IDEASOPHIA (dark & light mode)
- **IDEASOPHIA Integration** — Terhubung langsung dengan platform edukasi dan riset IDEASOPHIA
- **Indonesian-first** — Lokalisasi Bahasa Indonesia lengkap, dokumentasi dwi-bahasa

## Edisi

| Edisi | Target | Deskripsi |
|-------|--------|-----------|
| **Full** | Peneliti & Developer | Semua tools sains, ML, astronomi, dev tools |
| **Lite** | Pelajar | KDE Plasma + Python scientific stack |
| **Astro** | Astronom | Fokus tools astronomi + teleskop control |

## Versioning

Setiap rilis dinamai dengan gunung berapi Indonesia:
- v1.0 **Merapi** (target rilis pertama)
- v2.0 **Semeru**
- v3.0 **Krakatau**

## Quick Start (Build)

```bash
# Install dependencies
sudo apt install live-build

# Build ISO
cd sophia-os
sudo ./scripts/build.sh
```

## Struktur Proyek

```
sophia-os/
├── config/              # live-build configuration
│   ├── package-lists/   # Daftar paket per kategori
│   ├── hooks/           # Build scripts
│   ├── includes.chroot/ # Custom files untuk filesystem
│   └── preseed/         # Installer preseed
├── branding/            # Aset visual
├── themes/              # KDE themes source
├── sophia-tools/        # Custom applications
├── scripts/             # Build & utility scripts
└── docs/                # Dokumentasi
```

## Kontribusi

Kami menyambut kontribusi dari komunitas! Lihat [CONTRIBUTING.md](docs/CONTRIBUTING.md) untuk panduan.

## Lisensi

- Kode: GPL v3
- Artwork: CC BY-SA 4.0
- Dokumentasi: CC BY-SA 4.0

---

**IDEASOPHIA — Ideas Grow Like Leaves Under Sunlight**
