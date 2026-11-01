# Product & Design Specification: Dedicated Project Case Studies

## 1. Vision & Concept
- **Route:** `/projects/[slug]`
- **Purpose:** In-depth engineering case studies showcasing machine learning pipelines, inference runtimes, testing harnesses, and software architectures.
- **Aesthetic Authority:** Deep-Dark Technical Blueprint
  - 100% matte black canvas (`#0a0a0a`)
  - Hairline grid guidelines (`#1a1a1a`)
  - Safety orange accents (`#ff4500`)
  - JetBrains Mono and Hanken Grotesk typography
  - High-density ASCII/diagrammatic blueprints and terminal telemetry
  - Distinctly separated from the landing page's dual-canvas off-white poster style

## 2. Content Architecture (Astro Content Collections)
- **Directory:** `src/content/projects/[slug].md`
- **Schema:** Defined with Zod in `src/content/config.ts`:
  - `title`: string
  - `subtitle`: string
  - `category`: 'PIPELINES' | 'RUNTIMES' | 'VERIFICATION' | 'ARCHITECTURE'
  - `status`: string (e.g., 'VERIFIED_0.00%')
  - `timeline`: string
  - `role`: string
  - `techStack`: string[]
  - `metrics`: Array<{ label: string, value: string, detail: string }>
  - `githubUrl`: string
  - `runCommand`: string

## 3. Page Structure
1. **Header / Topbar:**
   - Tactile back control: `[← WORKS // ESC]`
   - Project indicator and live clock
2. **Hero Telemetry:**
   - Giant project title, subtitle, category pill, and primary status badge
   - Quick action badges: `[VIEW ON GITHUB ↗]`, `[RUN CLI]`, `[METRICS]`
3. **Problem Context & Root Cause:**
   - Why the system needed to be built, real-world failure modes addressed
4. **System Architecture Blueprint:**
   - Detailed ASCII/blueprint flow illustrating Ports, Adapters, and data boundaries
5. **Implementation & Code Contracts:**
   - Key code snippets, Pydantic/POSIX signal implementations, typing guarantees
6. **Benchmark & Defensive Verification Matrix:**
   - Latency, throughput, memory, and boundary isolation metrics
7. **Trade-offs & Lessons Learned:**
   - Engineering decisions, alternatives considered (e.g. ONNX vs TensorRT, Polars vs Pandas)
8. **Inter-Project Navigation:**
   - `[← PREV PROJECT]` and `[NEXT PROJECT →]` pagination

---

## 4. Multi-Page Architecture Roadmap

### Phase 1: Dedicated Project Case Studies [COMPLETED]
- **Route:** `/projects/[slug]`
- **Scope:** 3 Deep-Dark Technical Blueprint case studies (`modelarena`, `finance-tracker`, `savebite`).
- **Integration:** Two-tier card triggers on landing page (Title/Card -> `/projects/[slug]`, `[SPEC]` -> Quick modal, `[SOURCE ↗]` -> GitHub).

### Phase 2: Printable Swiss Technical CV (`/resume`) [COMPLETED]
- **Route:** `/resume`
- **Scope:** Clean, distraction-free, print-optimized (`@media print` cleanly formatted to single/dual A4 sheet) curriculum vitae.
- **Features:** 
  - Direct `[PRINT / SAVE PDF]` action button.
  - Plain text ATS-friendly copy button.
  - Structured academic coursework at Universitas Indonesia (2025—Present).
  - Systems & MLE skills matrix, verified open-source contributions.
  - Seamless navigation integration across Navbar (desktop & mobile drawer) and Hero action badges.

### Phase 2.5: Swiss Telemetry Transitions & Global Command Palette (Batch 1) [ACTIVE EXECUTION]
- **Components:**
  - `src/components/PageTransition.astro` (Swiss telemetry boot sequence 000% → 100% on landing page + continuous upward wipe shutter with Safety Orange leading edge).
  - `src/components/CommandPalette.astro` (Keyboard-first `Ctrl + K` / `Cmd + K` Swiss terminal modal for rapid navigation and actions).
  - SEO foundation (`@astrojs/sitemap`, `robots.txt`, dynamic schema.org JSON-LD & OpenGraph metadata).
  - Full data synchronization of `leakguard-ml` across `ProjectSpecModal.astro`.

### Phase 3: Technical Field Notes & Engineering Journal (`/notes`) (Batch 2) [COMPLETED]
- **Target Routes:** `/notes` (chronological directory) and `/notes/[slug]` (deep-read editorial view).
- **RSS Route:** `/rss.xml` (automated Astro syndication feed).
- **Content Collection Schema (`src/content.config.ts`):**
  - `title`: string
  - `subtitle`: string
  - `publishedAt`: string (YYYY-MM-DD)
  - `category`: 'MACHINE LEARNING' | 'SYSTEMS ARCHITECTURE' | 'VERIFICATION & DATA'
  - `readingTime`: string (e.g., '6 MIN READ')
  - `abstract`: string
  - `invariants`: string[]
  - `featured`: boolean
- **Initial Authentic Dispatches:**
  1. `posix-signals-async-python.md`: *POSIX Signal Traps in Async Python Inference Runtimes (Handling SIGTERM, graceful batch draining, and avoiding zombie worker pools)*
  2. `eliminating-lookahead-bias.md`: *Eliminating Lookahead Bias in Rolling Splits (Strict temporal data boundaries and purge-embargo validation for financial time-series)*
  3. `hexagonal-architecture-feature-stores.md`: *Hexagonal Architecture for ML Feature Stores (Decoupling feature serving contracts from storage drivers)*
- **Completed Deliverables:**
  - Full Content Collection schema with Zod typing in `src/content.config.ts`.
  - 3 high-density engineering write-ups with ASCII blueprints, formal equations, and JetBrains Mono snippets.
  - Interactive archive `/notes` with live keyword search, domain filtering, and dynamic reading time calculation.
  - Deep-read `/notes/[slug]` page with Swiss editorial styling, reading progress bar, sticky TOC with scrollspy, and inter-note navigation.
  - RSS 2.0 feed at `/rss.xml` with auto-discovery tag in Layout.
  - Cross-navigation integration across Navbar, Command Palette (`⌘K`), Footer, and Hero quick badges.

### Phase 4: Interactive Systems Telemetry & In-Browser Simulators [COMPLETED]
- **Target Routes:** 
  - `/notes/eliminating-lookahead-bias#interactive-simulator`
  - `/projects/modelarena#interactive-simulator`
- **Simulators Implemented:**
  1. `TemporalSplitterSimulator.astro`: Zero-dependency reactive SVG time-series visualizer. Manipulates label prediction horizon ($\tau$), embargo buffer ($h$), and contrasts Naive vs Purged validation partitions with live leakage index calculation and Sharpe projection.
  2. `ModelArenaVramSimulator.astro`: Zero-dependency multi-agent dynamic VRAM arbiter console. Simulates real-time shared memory ring-buffer reallocations (+40% compute boosts to high-gradient agents, throttling stagnating candidates) with streaming IPC terminal telemetry.
- **Entry Points & Global Access:**
  - Tactile `[► SIM]` badges on ModelArena card (`Projects.astro`) and note card (`notes/index.astro`).
  - Hero action badges `[LIVE SIMULATOR ►]` on `/projects/modelarena` and `/notes/eliminating-lookahead-bias`.
  - Direct search shortcuts in Command Palette (`⌘K`): `SIMULATE: Purge-Embargo Splitter` and `SIMULATE: ModelArena Dynamic VRAM Arbiter`.

### Phase 4.5: Principles & Tech Stack Component Redesign [COMPLETED]
- **Principles.astro (Interactive Invariant Sandbox):**
  - P-01: Live Contamination Toggle (`PASS: ZERO_LEAKAGE` vs `FAIL: LOOKAHEAD_VIOLATION`).
  - P-02: Live SIGTERM Worker Drain chaos injection test (`WORKER EXITED WITH CODE 0 ✓`).
  - P-03: Live Pydantic v2 strict contract injection (`ValidationError: Extra inputs forbidden`).
- **Skills.astro (Split Matrix & Live Telemetry Inspector):**
  - Desktop 12-col split: 7 cols categorized list + 5 cols sticky real-time telemetry inspector (Invariant role, Production benchmark, `[USED IN: PROJ ↗]`).
  - Mobile inline mechanical accordion expansion beneath selected item.
  - 150ms cubic-bezier transition, hairline scanline indicator, and subtle Web Audio synthesizer clicks.

### Phase 5: Advanced Systems Capabilities & Distribution Roadmap [PLANNED]
- **5.1 In-Browser UNIX / REPL Terminal Drawer (`~` / `⌘J`):**
  - Interactive sliding drawer terminal with native command parser (`help`, `cat`, `run [proj]`, `eval`, `benchmark`, `whoami`, `curl /contact`).
  - Real-time ASCII stdout streaming logs, loss bars, and IPC memory statistics.
- **5.2 Hardware Roofline Model & Compute Profiler:**
  - Double logarithmic interactive SVG canvas (FLOPs/Byte vs GFLOP/s) comparing A100 vs RTX 4090 vs T4.
  - Interactive precision selectors (`FP32`, `BF16`, `INT8`, `INT4 AWQ`) and batch size sliders illustrating memory-bound vs compute-bound transitions.
- **5.3 Dynamic Swiss OpenGraph Social Cards:**
  - High-resolution (1200x630) automated Swiss editorial preview cards with dark grid canvas, Hanken Grotesk typography, and verified metrics.
- **5.4 Interactive Architecture Topology DAG:**
  - Reactive SVG node-edge pipeline topology diagram with packet pulses, schema contract inspector, and latency SLA verification.
- **5.5 Code & Formula Deep Annotation Inspector:**
  - Interactive mathematical parameter drilldowns and line-by-line engineering justification overlays in technical dispatches.

---

## 5. Master Execution Prompts (Ready-to-Use Directives)

Berikut adalah prompt eksekusi teknis terstruktur untuk setiap inisiatif yang belum diimplementasikan:

### PROMPT 1: Perombakan Principles & Tech Stack (Phase 4.5)
```markdown
Implementasikan perombakan total pada komponen `src/components/Principles.astro` dan `src/components/Skills.astro` agar tidak lagi berupa teks statis biasa, melainkan mengikuti standar Awwwards / Swiss Brutalist tingkat tinggi:

1. Modifikasi `src/components/Principles.astro` (Interactive Invariant Sandbox):
   - Ubah tiap kartu prinsip menjadi sandbox mikro interaktif yang dapat diuji langsung oleh pengunjung:
     a. Prinsip P-01 (Zero Data Leakage): Buat tombol toggle `[TEST: CONTAMINATED vs PURGED]`. Saat diklik, perbarui visualisasi rentang waktu dan jalankan kode assert live. Tampilkan badge status dinamis `PASS: ZERO_LEAKAGE` (hijau/aksen) vs `FAIL: LOOKAHEAD_VIOLATION` (merah).
     b. Prinsip P-02 (Defensive Verification & Chaos): Buat tombol `[TEST: INJECT SIGTERM]`. Saat diklik, simulasikan penghentian proses pekerja dengan delay 300ms, streaming log terminal mini: `[INTERRUPT] Received SIGTERM... Draining batch (12/12)... Process exited with code 0 (No zombies) ✓`.
     c. Prinsip P-03 (Domain Isolation & Contracts): Buat tombol toggle `[TEST: INJECT STRICT PAYLOAD]`. Saat diklik dengan payload ilegal (misal penambahan field `extra_param`), tampilkan output error Pydantic v2 nyata: `ValidationError: Extra inputs are not permitted [type=extra_forbidden]`.
   - Gunakan transisi 150ms cubic-bezier(0.16, 1, 0.3, 1), monospaced badge, dan integrasikan audio klik halus via Web Audio synthesizer yang ada.

2. Modifikasi `src/components/Skills.astro` (Split Matrix & Live Telemetry Inspector):
   - Di desktop (lg:grid-cols-12), ubah layout menjadi Split Grid:
     a. Sisi Kiri (7 Kolom): Daftar teknologi terstruktur per kategori (LANG, MLE, ARCH, TEST). Saat baris di-hover atau aktif, terapkan efek monochrome color inversion seketika (`bg-black text-white` atau `bg-accent text-black`) dengan aksen garis pemindai (scanline).
     b. Sisi Kanan (5 Kolom): Panel Inspector Terkunci (`sticky top-28`) yang reaktif memperbarui detail teknologi yang dipilih:
        - PARAMETER_NAME & CATEGORY_CLASS
        - SYSTEM_INVARIANT: Peran teknis arsitektural (misal PyTorch: "Custom autograd hooks & sliding memory pool allocator", C++: "Zero-copy shared memory IPC ring-buffer /dev/shm", DuckDB: "Zero-copy Apache Arrow integration").
        - PRODUCTION_TELEMETRY: Benchmark nyata (misal: "CUDA 12.4 // TensorRT", "< 1.2ms join latency").
        - INTEGRATED_BLUEPRINT: Tombol tautan internal langsung ke studi kasus proyek (`[USED IN: MODELARENA ↗]` atau `[USED IN: LEAKGUARD-ML ↗]`).
   - Di layar mobile/tablet (< 1024px):
     Terapkan Responsive Inline Expansion (akordeon mekanis) tepat di bawah item yang di-tap agar pengunjung tidak perlu scroll bolak-balik.

3. Standar & Kualitas:
   - Pertahankan estetika Swiss Brutalist murni: hitam `#0a0a0a`, off-white `#f6f6f6`, safety orange `#ff4500`, font JetBrains Mono & Hanken Grotesk.
   - Tanpa emoji konsumen; gunakan glif geometris (`►`, `●`, `✓`, `↗`).
   - Pastikan `npm run build` berhasil dengan exit code 0 tanpa error TypeScript/Astro.
```

---

### PROMPT 2: In-Browser Interactive UNIX / REPL Terminal Drawer (Phase 5.1)
```markdown
Bangun komponen terminal interaktif bergaya UNIX monospaced di `src/components/TerminalDrawer.astro` dan integrasikan ke `src/layouts/Layout.astro`:

1. Spesifikasi Tampilan & UX:
   - Panel drawer sliding dari bawah layar (tinggi 42vh di desktop, 60vh di mobile).
   - Header bar berisi: `[TERMINAL // RESHANDY_KERNEL_v2.4]`, indikator status live `IPC: CONNECTED`, tombol resize `[MAX]`, dan tombol tutup `[ESC / CLOSE]`.
   - Tombol pemicu: Shortcut keyboard global backtick (`` ` `` / `~`) atau `⌘J` / `Ctrl+J`, serta badge `[TERM $]` di Navbar atau Footer.

2. Engine Command Line REPL (Client-Side Pure TypeScript):
   - Sediakan parser perintah monospaced dengan cursor berkedip:
     a. `help` — Tabel kamus perintah, argumen, dan deskripsi singkat.
     b. `whoami` — Data profil kandidat (Reshandy Taftazani Aulya, CS @ UI, MLE & Systems).
     c. `cat [modelarena|finance-tracker|savebite]` — Menampilkan arsitektur JSON dan metrik terverifikasi proyek.
     d. `run modelarena --train` — Menjalankan simulasi training multi-agent dengan streaming stdout ASCII log (1 baris per 100ms) dilengkapi progres bar loss:
        `[EPOCH 01/05] Loss: 0.384 | Speed: 1,420 tok/s [=========> ] 62%`
     e. `eval --split test` — Menampilkan tabel Sharpe ratio, maximum drawdown, dan latency inference.
     f. `curl /contact` — Menampilkan kontak email, PGP public key fingerprint, dan link GitHub/LinkedIn.
     g. `clear` / `exit` — Membersihkan layar terminal / menutup panel drawer.
   - Dukung history navigasi perintah dengan tombol panah atas/bawah (Up/Down arrow key).

3. Verifikasi & Integrasi:
   - Cegah konflik shortcut saat pengguna sedang mengetik di input form atau dialog Command Palette (`⌘K`).
   - Pastikan performa 60fps tanpa memory leak pada streaming interval, dan `npm run build` sukses 100%.
```

---

### PROMPT 3: Hardware Roofline Model & Compute Profiler (Phase 5.2)
```markdown
Bangun komponen visualisator Roofline Model interaktif di `src/components/RooflineModelSimulator.astro` dan sematkan pada halaman studi kasus `/projects/modelarena#hardware-roofline`:

1. Konsep Teoretis & Formula:
   - Sumbu X: Operational / Arithmetic Intensity (FLOPs/Byte) skala logaritmik (0.01 hingga 100).
   - Sumbu Y: Attainable Performance (GFLOP/s) skala logaritmik (1 hingga 20,000).
   - Garis Roofline: Terdiri dari batas miring *Memory Bandwidth Ceiling* ($Y = \text{Bandwidth} \times X$) dan batas datar *Peak Compute Ceiling* ($Y = \text{Peak FLOPS}$).

2. Kontrol Interaktif:
   - Selector Hardware Target:
     * NVIDIA A100 SXM4 (Bandwidth: 1,555 GB/s, Peak FP16: 312,000 GFLOP/s)
     * NVIDIA RTX 4090 (Bandwidth: 1,008 GB/s, Peak FP16: 82,600 GFLOP/s)
     * NVIDIA T4 (Bandwidth: 320 GB/s, Peak FP16: 65,000 GFLOP/s)
   - Selector Precision / Quantization: `FP32`, `FP16 / BF16`, `INT8 TensorCore`, `INT4 AWQ`.
   - Slider Interaktif:
     * Batch Size ($B \in [1, 128]$)
     * Context / Sequence Length ($L \in [128, 4096]$)

3. Visualisasi Canvas / SVG:
   - Gambar garis atap (roofline) dinamis sesuai hardware yang dipilih.
   - Tampilkan titik koordinat operasi aktual ModelArena ($X_{\text{current}}, Y_{\text{current}}$).
   - Badge Status Real-time: Otomatis mendeteksi dan memberi label:
     `● STATUS: MEMORY_BOUND (Bounded by HBM Bandwidth)` vs `● STATUS: COMPUTE_BOUND (Saturating Tensor Cores)`.
   - Teks penjelasan teknis di bawah canvas yang menjelaskan justifikasi arsitektur zero-copy ring buffer ModelArena.

4. Standar:
   - Zero-dependency canvas/SVG, responsif pada desktop dan mobile, tipografi JetBrains Mono.
   - Verifikasi kompilasi `npm run build` bersih tanpa error.
```

---

### PROMPT 4: Dynamic Swiss Open Graph (OG) Social Cards (Phase 5.3)
```markdown
Rancang dan implementasikan sistem generasi otomatis gambar preview media sosial (Open Graph & Twitter Card) bergaya Swiss Editorial untuk semua rute di portofolio:

1. Generator Endpoint (`src/pages/api/og/[...slug].png.ts` atau layout pre-rendering):
   - Dimensi standar: 1200 x 630 px.
   - Canvas: Pitch-black (`#0a0a0a`) dengan grid guidelines halus 12-kolom (`#161616`).
   - Header Bar: `[CS @ UNIVERSITAS INDONESIA // RESHANDY TAFTAZANI]`.
   - Tipografi Judul: *Hanken Grotesk* tebal (ukuran 56-64px), kontras tinggi off-white (`#f6f6f6`), dengan aksen titik oranye (`#ff4500`).
   - Subtitle & Metadata Box: Kategori artikel/proyek, metrik utama (misal `ZERO_LEAKAGE // SHARPE 2.41`), dan tanggal rilis.
   - Footer Bar: Corner crosshairs `+`, status verifikasi `[VERIFIED SYSTEMS ARCHITECTURE ✓]`, dan URL `reshandytaftazani.github.io`.

2. Integrasi Tag Metadata di `src/layouts/Layout.astro` & Halaman Dinamis:
   - Tambahkan tag ke `<head>`:
     `<meta property="og:image" content={ogImageURL} />`
     `<meta property="og:image:width" content="1200" />`
     `<meta property="og:image:height" content="630" />`
     `<meta name="twitter:card" content="summary_large_image" />`
     `<meta name="twitter:image" content={ogImageURL} />`
   - Dukung gambar dinamis untuk `/notes/[slug]` dan `/projects/[slug]` yang mengekstrak judul artikel dan metrik spesifik secara otomatis.

3. Validasi:
   - Uji respon metadata menggunakan Twitter Card / OpenGraph markup validator simulator.
   - Pastikan build static Astro tetap berjalan lancar (`npm run build` sukses).
```

---

### PROMPT 5: Interactive Architecture Topology & Data Pipeline DAG (Phase 5.4)
```markdown
Bangun komponen visualisasi topologi arsitektur sistem di `src/components/ArchitectureTopologyDAG.astro` dan sematkan pada halaman cetak biru proyek `/projects/modelarena` dan `/projects/finance-tracker`:

1. Visualisasi Node-Edge DAG (Directed Acyclic Graph):
   - Diagram berbasis SVG hairline presisi tinggi yang merepresentasikan pipeline microservice:
     [Raw Event Ingestion] → [Purge & Embargo Guard] → [DuckDB Engine] → [Redis Low-Latency Cache] → [Triton Inference Workers] → [Arbitration Telemetry]
   - Animasi denyut paket data (*packet pulse*) bergerak di sepanjang garis penghubung dari kiri ke kanan.

2. Interaktivitas Telemetry Inspector:
   - Setiap node simpul dapat diklik (dengan status seleksi aktif beraksen oranye).
   - Mengklik node membuka panel inspeksi detail di samping/bawah:
     a. Node Name & Process Type (misal: `Async Worker Pool / Tokio IPC`).
     b. Schema Contract: Definisi Pydantic v2 / Apache Arrow schema.
     c. Latency SLA Budget: Alokasi latency per hop (misal: `P99 < 1.4ms`).
     d. Failure Policy: Aturan fallback saat worker gagal (misal: `Circuit Breaker: Drains to Dead-Letter Queue`).

3. Responsivitas & Estetika:
   - Mode scroll horizontal atau auto-fit pada layar kecil dengan kontrol tombol zoom/reset sederhana.
   - Estetika monospaced brutalist yang selaras dengan seluruh portofolio.
   - Pastikan `npm run build` berhasil tanpa warning.
```

---

### PROMPT 6: Code & Mathematical Formula Interactive Annotation Inspector (Phase 5.5)
```markdown
Tingkatkan halaman pembaca teknis `src/pages/notes/[slug].astro` dengan sistem anotasi interaktif untuk blok kode dan rumus matematika:

1. Anotasi Rumus Matematika (KaTeX / Math Symbols):
   - Pada artikel seperti `eliminating-lookahead-bias.md`, buat simbol parameter penting ($\tau$, $h$, $t_i$, $c_k$) menjadi tombol glif interaktif.
   - Saat simbol diklik, buka callout drawer halus yang menjelaskan signifikansi rekayasanya:
     * Misal saat $\tau$ diklik: Munculkan callout "Prediction Horizon ($\tau$): Batas waktu pelabelan masa depan; jika data fitur ditarik dalam rentang ini tanpa purging, lookahead bias terjadi secara matematis."

2. Anotasi Baris Kode (Line-Level Justification Callouts):
   - Pada snippet kode JetBrains Mono, tambahkan penanda titik aksen pada baris kritis (misal baris pemanggilan `signal.signal(signal.SIGTERM, handler)`).
   - Mengklik baris tersebut akan memunculkan kartu callout yang menguraikan alasan arsitektural (misal: "Mengapa loop default Python mengabaikan SIGTERM jika thread multiprocessing sedang memblokir GIL").

3. UX & Navigasi:
   - Mengklik di luar callout atau menekan `Escape` akan menutup anotasi.
   - Animasi munculan 150ms dengan font JetBrains Mono dan border hairline `#ff4500`/30.
   - Pastikan tidak merusak fungsi TOC scrollspy dan reading progress bar yang sudah ada.
   - Jalankan `npm run build` untuk memverifikasi kompatibilitas.
```

