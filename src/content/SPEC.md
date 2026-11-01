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

### Phase 3: Technical Field Notes & Engineering Journal (`/notes`) (Batch 2) [PLANNED SPECIFICATION & PROMPT]
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
- **Prompt Eksekusi Batch 2 untuk Sesi Berikutnya:**
  ```text
  Lanjutkan pengembangan portofolio (Reshandy Taftazani Aulya — CS @ Universitas Indonesia, MLE & Systems) sesuai SPEC.md Phase 3:
  1. Konfigurasi Content Collection `notes` di `src/content.config.ts` sesuai skema Zod.
  2. Buat 3 artikel teknis autentik di `src/content/notes/` dengan format markdown presisi, rumus/diagram ASCII, dan snippet kode JetBrains Mono.
  3. Bangun halaman arsip `/notes` (src/pages/notes/index.astro) dengan live search, filter domain tag, dan kalkulasi reading time.
  4. Bangun halaman pembaca `/notes/[slug]` (src/pages/notes/[slug].astro) dengan gaya Swiss editorial, reading progress indicator, TOC, dan inter-note navigation.
  5. Konfigurasi feed RSS di `/rss.xml.ts` menggunakan `@astrojs/rss`.
  6. Integrasikan tautan `/notes` ke Navbar, Command Palette, dan Footer.
  ```

