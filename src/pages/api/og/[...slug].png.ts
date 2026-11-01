import type { APIRoute } from 'astro';
import { getCollection } from 'astro:content';
import { Resvg } from '@resvg/resvg-js';

export const prerender = true;

interface OGProps {
  title: string;
  subtitle: string;
  category: string;
  primaryMetric: string;
  date: string;
  domain: string;
  specType?: string;
}

function escapeXml(unsafe: unknown): string {
  return String(unsafe ?? '')
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&apos;');
}

function wrapText(text: string, maxCharsPerLine: number): string[] {
  const words = text.trim().split(/\s+/);
  const lines: string[] = [];
  let currentLine = '';

  for (const word of words) {
    if ((currentLine + (currentLine ? ' ' : '') + word).length <= maxCharsPerLine) {
      currentLine += (currentLine ? ' ' : '') + word;
    } else {
      if (currentLine) lines.push(currentLine);
      currentLine = word;
    }
  }
  if (currentLine) lines.push(currentLine);
  return lines;
}

function generateOgSvg({
  title,
  subtitle,
  category,
  primaryMetric,
  date,
  domain,
  specType = 'VERIFIED SPEC',
}: OGProps): string {
  const width = 1200;
  const height = 630;

  // 12-column grid lines from 60 to 1140 with step 90
  let gridLines = '';
  for (let i = 0; i <= 12; i++) {
    const x = 60 + i * 90;
    gridLines += `<line x1="${x}" y1="60" x2="${x}" y2="570" stroke="#161616" stroke-width="1" />\n`;
  }

  // Adaptive title typography
  let fontSize = 56;
  let lineHeight = 66;
  let maxChars = 34;

  if (title.length > 55) {
    fontSize = 44;
    lineHeight = 54;
    maxChars = 42;
  } else if (title.length < 24) {
    fontSize = 64;
    lineHeight = 74;
    maxChars = 26;
  }

  const titleLines = wrapText(title, maxChars).slice(0, 3);
  const startY = titleLines.length === 1 ? 255 : titleLines.length === 2 ? 230 : 210;

  const titleSvgLines = titleLines
    .map((line, idx) => {
      const isLast = idx === titleLines.length - 1;
      const y = startY + idx * lineHeight;
      return `<text x="80" y="${y}" class="sans" font-size="${fontSize}" font-weight="800" fill="#f6f6f6" letter-spacing="-1.5">${escapeXml(line)}${
        isLast ? '<tspan fill="#ff4500">.</tspan>' : ''
      }</text>`;
    })
    .join('\n');

  // Subtitle positioning below title
  const subtitleY = startY + (titleLines.length - 1) * lineHeight + 48;
  const subtitleLines = wrapText(subtitle, 70).slice(0, 2);
  const subtitleSvgLines = subtitleLines
    .map((line, idx) => {
      const y = subtitleY + idx * 26;
      return `<text x="80" y="${y}" class="sans" font-size="19" font-weight="400" fill="#9b9b9b" letter-spacing="-0.2">${escapeXml(line)}</text>`;
    })
    .join('\n');

  // Category pill width calculation
  const categoryText = category.toUpperCase();
  const pillWidth = Math.max(150, categoryText.length * 9.5 + 32);

  return `
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${width} ${height}" width="${width}" height="${height}">
  <defs>
    <style>
      .mono { font-family: 'JetBrains Mono', Consolas, 'Courier New', monospace; }
      .sans { font-family: 'Hanken Grotesk', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; }
    </style>
  </defs>

  <!-- Pitch Black Canvas -->
  <rect width="${width}" height="${height}" fill="#0a0a0a" />

  <!-- 12-Column Grid Lines -->
  ${gridLines}

  <!-- Outer Frame Hairline Borders -->
  <rect x="60" y="60" width="1080" height="510" fill="none" stroke="#202020" stroke-width="1" />

  <!-- Crosshair corners (pure vector + markers) -->
  <!-- Top Left -->
  <line x1="52" y1="60" x2="68" y2="60" stroke="#ff4500" stroke-width="2" />
  <line x1="60" y1="52" x2="60" y2="68" stroke="#ff4500" stroke-width="2" />
  <!-- Top Right -->
  <line x1="1132" y1="60" x2="1148" y2="60" stroke="#ff4500" stroke-width="2" />
  <line x1="1140" y1="52" x2="1140" y2="68" stroke="#ff4500" stroke-width="2" />
  <!-- Bottom Left -->
  <line x1="52" y1="570" x2="68" y2="570" stroke="#ff4500" stroke-width="2" />
  <line x1="60" y1="562" x2="60" y2="578" stroke="#ff4500" stroke-width="2" />
  <!-- Bottom Right -->
  <line x1="1132" y1="570" x2="1148" y2="570" stroke="#ff4500" stroke-width="2" />
  <line x1="1140" y1="562" x2="1140" y2="578" stroke="#ff4500" stroke-width="2" />

  <!-- Header Bar -->
  <line x1="60" y1="105" x2="1140" y2="105" stroke="#202020" stroke-width="1" />
  
  <text x="80" y="89" class="mono" font-size="12" font-weight="700" fill="#9b9b9b" letter-spacing="1.5">
    [CS @ UNIVERSITAS INDONESIA // RESHANDY TAFTAZANI]
  </text>
  
  <circle cx="975" cy="85" r="4" fill="#00ff66" />
  <text x="1120" y="89" class="mono" font-size="12" font-weight="600" fill="#f6f6f6" text-anchor="end" letter-spacing="1">
    IPC: CONNECTED // KERNEL v2.4
  </text>

  <!-- Category Badge -->
  <rect x="80" y="132" width="${pillWidth}" height="26" fill="#121212" stroke="#ff4500" stroke-width="1" />
  <text x="${80 + pillWidth / 2}" y="149" class="mono" font-size="11" font-weight="700" fill="#ff4500" text-anchor="middle" letter-spacing="1.5">
    [ ${escapeXml(categoryText)} ]
  </text>
  <text x="${80 + pillWidth + 14}" y="149" class="mono" font-size="11" font-weight="600" fill="#6b6b6b" letter-spacing="1.5">
    // ${escapeXml(specType.toUpperCase())}
  </text>

  <!-- Dynamic Title -->
  ${titleSvgLines}

  <!-- Subtitle -->
  ${subtitleSvgLines}

  <!-- Metadata Callout Box -->
  <rect x="80" y="425" width="1040" height="76" fill="#101010" stroke="#242424" stroke-width="1" />
  
  <!-- Column 1: Primary Metric -->
  <text x="105" y="448" class="mono" font-size="10" font-weight="600" fill="#6b6b6b" letter-spacing="1.5">
    PRIMARY VERIFIED METRIC
  </text>
  <text x="105" y="479" class="mono" font-size="16" font-weight="700" fill="#ff4500" letter-spacing="0.5">
    ${escapeXml(primaryMetric)}
  </text>

  <!-- Divider 1 -->
  <line x1="450" y1="425" x2="450" y2="501" stroke="#222222" stroke-width="1" />

  <!-- Column 2: Systems Domain -->
  <text x="475" y="448" class="mono" font-size="10" font-weight="600" fill="#6b6b6b" letter-spacing="1.5">
    SYSTEMS DOMAIN
  </text>
  <text x="475" y="479" class="mono" font-size="14" font-weight="600" fill="#f6f6f6" letter-spacing="0.5">
    ${escapeXml(domain)}
  </text>

  <!-- Divider 2 -->
  <line x1="770" y1="425" x2="770" y2="501" stroke="#222222" stroke-width="1" />

  <!-- Column 3: Status / Release -->
  <text x="795" y="448" class="mono" font-size="10" font-weight="600" fill="#6b6b6b" letter-spacing="1.5">
    STATUS / TIMELINE
  </text>
  <text x="795" y="479" class="mono" font-size="14" font-weight="600" fill="#f6f6f6" letter-spacing="0.5">
    ${escapeXml(date)}
  </text>

  <!-- Footer Line -->
  <line x1="60" y1="535" x2="1140" y2="535" stroke="#202020" stroke-width="1" />

  <!-- Footer Elements -->
  <text x="80" y="556" class="mono" font-size="12" font-weight="600" fill="#888888" letter-spacing="1">
    [VERIFIED SYSTEMS ARCHITECTURE ✓]
  </text>

  <text x="1120" y="556" class="mono" font-size="13" font-weight="700" fill="#f6f6f6" text-anchor="end" letter-spacing="0.5">
    reshandytaftazani.github.io
  </text>
</svg>
`;
}

export async function getStaticPaths() {
  const projects = await getCollection('projects');
  const notes = await getCollection('notes');

  const paths = [
    // Default / Index
    {
      params: { slug: 'default' },
      props: {
        title: 'Reshandy Taftazani Aulya',
        subtitle: 'Machine Learning Engineering & Software Systems focused on zero data leakage and clean architecture',
        category: 'PORTFOLIO // OVERVIEW',
        primaryMetric: 'ZERO_LEAKAGE // SHARPE 2.41',
        date: 'CS @ FASILKOM UI',
        domain: 'ML & SYSTEMS ENGINEERING',
        specType: 'PORTFOLIO HOMEPAGE',
      } as OGProps,
    },
    // Projects Directory
    {
      params: { slug: 'projects' },
      props: {
        title: 'Engineering Projects Directory',
        subtitle: 'Comprehensive archival catalog of verified machine learning frameworks, distributed platforms, and pipelines',
        category: 'SYSTEMS DIRECTORY',
        primaryMetric: '4 VERIFIED REPOSITORIES',
        date: 'SYSTEM CATALOG 2026',
        domain: 'HIGH-PERFORMANCE ARCHITECTURE',
        specType: 'ARCHIVAL DIRECTORY',
      } as OGProps,
    },
    // Notes Directory
    {
      params: { slug: 'notes' },
      props: {
        title: 'Technical Field Notes & Dispatches',
        subtitle: 'Engineering journal on distributed runtimes, defensive temporal verification, and zero-leakage systems',
        category: 'DISPATCH DIRECTORY',
        primaryMetric: 'PEER-VERIFIED DISPATCHES',
        date: 'JOURNAL ARCHIVE',
        domain: 'RESEARCH & VERIFICATION',
        specType: 'ENGINEERING JOURNAL',
      } as OGProps,
    },
    // Resume
    {
      params: { slug: 'resume' },
      props: {
        title: 'Curriculum Vitae & Technical Spec',
        subtitle: 'Reshandy Taftazani Aulya — Computer Science at Universitas Indonesia (Fasilkom UI)',
        category: 'ENGINEERING DOSSIER',
        primaryMetric: 'FASILKOM UI // CLASS OF 2025',
        date: 'DOC-REF: RTA-CV-2026',
        domain: 'ML & SYSTEMS ENGINEERING',
        specType: 'CURRICULUM VITAE',
      } as OGProps,
    },
    // Dynamic Projects
    ...projects.map((project) => {
      const primaryMetric =
        project.data.metrics && project.data.metrics.length > 0
          ? `${project.data.metrics[0].label}: ${project.data.metrics[0].value}`
          : 'ZERO_LEAKAGE // VERIFIED';

      const techStackSummary = project.data.techStack?.slice(0, 3).join(' • ') || 'SOFTWARE SYSTEMS';

      return {
        params: { slug: `projects/${project.id}` },
        props: {
          title: project.data.title,
          subtitle: project.data.subtitle,
          category: project.data.category || 'PROJECT ARCHITECTURE',
          primaryMetric,
          date: project.data.timeline || '2026 SPEC',
          domain: techStackSummary,
          specType: 'PROJECT SPEC SHEET',
        } as OGProps,
      };
    }),
    // Dynamic Notes
    ...notes.map((note) => {
      const primaryMetric =
        note.data.invariants && note.data.invariants.length > 0
          ? note.data.invariants[0]
          : 'MATHEMATICALLY FORMAL';

      const truncatedMetric =
        primaryMetric.length > 36 ? primaryMetric.slice(0, 33) + '...' : primaryMetric;

      return {
        params: { slug: `notes/${note.id}` },
        props: {
          title: note.data.title,
          subtitle: note.data.subtitle || note.data.abstract,
          category: note.data.category,
          primaryMetric: truncatedMetric,
          date: note.data.publishedAt,
          domain: note.data.readingTime || 'TECHNICAL DISPATCH',
          specType: 'FIELD DISPATCH',
        } as OGProps,
      };
    }),
  ];

  return paths;
}

export const GET: APIRoute = async ({ props }) => {
  const ogProps = props as OGProps;
  const svg = generateOgSvg(ogProps);

  const resvg = new Resvg(svg, {
    fitTo: { mode: 'width', value: 1200 },
    shapeRendering: 2,
    textRendering: 1,
  });

  const pngBuffer = resvg.render().asPng();

  return new Response(pngBuffer, {
    headers: {
      'Content-Type': 'image/png',
      'Cache-Control': 'public, max-age=31536000, immutable',
    },
  });
};
