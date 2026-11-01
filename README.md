# reshandytaftazani.github.io

> Professional portfolio of **Reshandy Taftazani Aulya** — Machine Learning & Software Systems Engineer.

Deployed live on GitHub Pages: [reshandytaftazani.github.io](https://reshandytaftazani.github.io)

---

## 🛠️ Tech Stack & Architecture

- **Framework:** [Astro](https://astro.build/) (v5 / v7 static site generation)
- **Styling:** [Tailwind CSS v4](https://tailwindcss.com/) (`@tailwindcss/vite`)
- **Typography:** Inter (Sans-serif) & JetBrains Mono (Monospace)
- **Design Philosophy:** Minimalist engineering dark theme (*high signal, low noise*)
- **Hosting & CI/CD:** GitHub Pages via GitHub Actions (`.github/workflows/deploy.yml`)

---

## 🚀 Local Development

### 1. Prerequisites
- **Node.js**: v20 or higher
- **npm**: v10 or higher

### 2. Installation
Clone the repository and install dependencies:
```bash
git clone https://github.com/reshandytaftazani/reshandytaftazani.github.io.git
cd reshandytaftazani.github.io
npm install
```

### 3. Run Dev Server
Start the local development server:
```bash
npm run dev
```
Open your browser at `http://localhost:4321`.

### 4. Build Static Site
To create a production static build:
```bash
npm run build
```
The compiled static output will be located in the `dist/` directory.

### 5. Preview Static Build
To preview the compiled static build locally:
```bash
npm run preview
```

---

## 🌐 GitHub Pages Deployment Setup

1. In your GitHub repository settings, navigate to **Settings** > **Pages**.
2. Under **Build and deployment** > **Source**, select **GitHub Actions**.
3. Push any commit to the `main` branch:
   ```bash
   git add .
   git commit -m "feat: complete portfolio setup with Astro and Tailwind CSS"
   git push origin main
   ```
4. The GitHub Actions workflow defined in `.github/workflows/deploy.yml` will automatically build the site and deploy it to `https://reshandytaftazani.github.io`.

---

## 📬 Contact & Links

- **GitHub:** [@reshandytaftazani](https://github.com/reshandytaftazani)
- **LinkedIn:** [Reshandy Taftazani Aulya](https://linkedin.com/in/reshandy-taftazani-aulya)
- **Email:** [reshandy.taftazani@ui.ac.id](mailto:reshandy.taftazani@ui.ac.id)
- **Institution:** Computer Science, [Universitas Indonesia](https://cs.ui.ac.id/)
