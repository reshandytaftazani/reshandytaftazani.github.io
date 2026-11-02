<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:atom="http://www.w3.org/2005/Atom">
  <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <html lang="en">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title><xsl:value-of select="/rss/channel/title"/> — RSS Feed</title>
        <link rel="preconnect" href="https://fonts.googleapis.com"/>
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin=""/>
        <link href="https://fonts.googleapis.com/css2?family=Hanken+Grotesk:wght@400;500;600;700;800;900&amp;family=JetBrains+Mono:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
        
        <!-- Pre-paint guard: If arriving via internal navigation, maintain shutter covering the screen before first paint -->
        <script><![CDATA[
          if (sessionStorage.getItem("swiss_nav_transition") === "fast") {
            document.documentElement.classList.add("swiss-shutter-covered");
          }
        ]]></script>

        <style><![CDATA[
          xslt-warning-banner {
            display: none !important;
            visibility: hidden !important;
            height: 0 !important;
            margin: 0 !important;
            padding: 0 !important;
          }

          :root {
            --bg: #0a0a0a;
            --card-bg: #121212;
            --fg: #f6f6f6;
            --accent: #ff4500;
            --border: #262626;
            --border-subtle: #1c1c1c;
            --neutral: #9b9b9b;
            --neutral-dark: #666666;
            --font-sans: 'Hanken Grotesk', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            --font-mono: 'JetBrains Mono', ui-monospace, SFMono-Regular, monospace;
          }

          * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
          }

          body {
            background-color: var(--bg);
            color: var(--fg);
            font-family: var(--font-sans);
            line-height: 1.5;
            -webkit-font-smoothing: antialiased;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
          }

          /* Continuous Upward Wipe Shutter */
          #swiss-shutter {
            position: fixed;
            inset: 0;
            background-color: #0a0a0a;
            border-top: 2px solid #ff4500;
            box-shadow: 0 -4px 28px rgba(255, 69, 0, 0.35);
            pointer-events: none;
            z-index: 99999;
            transform: translate3d(0, 100%, 0);
            display: none;
            will-change: transform;
          }

          html.swiss-shutter-covered #swiss-shutter {
            display: block !important;
            transform: translate3d(0, 0, 0) !important;
          }

          /* Subtle Engineering Grid Guidelines */
          .grid-backdrop {
            position: fixed;
            inset: 0;
            background-image: 
              linear-gradient(to right, rgba(255, 255, 255, 0.02) 1px, transparent 1px),
              linear-gradient(to bottom, rgba(255, 255, 255, 0.02) 1px, transparent 1px);
            background-size: 32px 32px;
            pointer-events: none;
            z-index: 0;
          }

          .container {
            width: 100%;
            max-width: 900px;
            margin: 0 auto;
            padding: 2rem 1.25rem 4rem;
            position: relative;
            z-index: 1;
          }

          /* Top Navigation & Telemetry Bar */
          .telemetry-bar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-family: var(--font-mono);
            font-size: 0.75rem;
            color: var(--neutral);
            border-bottom: 1px solid var(--border);
            padding-bottom: 1rem;
            margin-bottom: 2rem;
          }

          .telemetry-bar a.back-link {
            color: var(--neutral);
            text-decoration: none;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.35rem 0.65rem;
            background-color: #121212;
            border: 1px solid var(--border);
            border-radius: 2px;
            transition: all 0.15s ease;
            cursor: pointer;
            user-select: none;
          }

          .telemetry-bar a.back-link:hover {
            color: #ffffff;
            border-color: var(--accent);
            background-color: #181818;
          }

          .back-arrow {
            color: var(--accent);
            font-weight: 800;
            transition: transform 0.15s ease;
          }

          .telemetry-bar a.back-link:hover .back-arrow {
            transform: translateX(-2px);
          }

          .esc-badge {
            font-family: var(--font-mono);
            font-size: 0.625rem;
            font-weight: 700;
            padding: 0.1rem 0.35rem;
            background-color: #080808;
            border: 1px solid #333333;
            border-radius: 2px;
            color: var(--accent);
            letter-spacing: 0.05em;
            transition: all 0.15s ease;
          }

          .telemetry-bar a.back-link:hover .esc-badge {
            background-color: var(--accent);
            border-color: var(--accent);
            color: #000000;
          }

          .status-pulse {
            display: inline-block;
            width: 7px;
            height: 7px;
            border-radius: 50%;
            background-color: var(--accent);
            box-shadow: 0 0 10px var(--accent);
            margin-right: 0.35rem;
          }

          /* Header Hero */
          .feed-header {
            margin-bottom: 2rem;
          }

          .feed-tag {
            font-family: var(--font-mono);
            font-size: 0.7rem;
            font-weight: 700;
            color: var(--accent);
            letter-spacing: 0.1em;
            text-transform: uppercase;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
          }

          .feed-title {
            font-size: clamp(1.75rem, 3.5vw, 2.5rem);
            font-weight: 900;
            letter-spacing: -0.03em;
            line-height: 1.1;
            color: #ffffff;
            margin-bottom: 0.75rem;
          }

          .feed-desc {
            font-size: 0.95rem;
            color: var(--neutral);
            line-height: 1.5;
            max-width: 720px;
          }

          /* Explanatory / Educational Banner Card */
          .education-card {
            background-color: var(--card-bg);
            border: 1px solid var(--border);
            padding: 1.5rem;
            margin-bottom: 2.5rem;
            position: relative;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
          }

          .education-card::before {
            content: "+";
            position: absolute;
            top: 4px;
            left: 6px;
            font-family: var(--font-mono);
            font-size: 10px;
            color: var(--neutral-dark);
          }
          .education-card::after {
            content: "+";
            position: absolute;
            bottom: 4px;
            right: 6px;
            font-family: var(--font-mono);
            font-size: 10px;
            color: var(--neutral-dark);
          }

          .edu-badge {
            font-family: var(--font-mono);
            font-size: 0.6875rem;
            font-weight: 700;
            color: var(--accent);
            letter-spacing: 0.05em;
            text-transform: uppercase;
            margin-bottom: 0.6rem;
            display: block;
          }

          .edu-heading {
            font-size: 1.1rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 0.5rem;
            letter-spacing: -0.015em;
          }

          .edu-text {
            font-size: 0.85rem;
            color: #cccccc;
            line-height: 1.55;
            margin-bottom: 1.25rem;
          }

          .edu-text strong {
            color: #ffffff;
          }

          .action-group {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 0.75rem;
          }

          .copy-btn {
            background-color: var(--accent);
            color: #000000;
            border: 1px solid var(--accent);
            padding: 0.6rem 1.1rem;
            font-family: var(--font-mono);
            font-size: 0.75rem;
            font-weight: 700;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.2s ease;
            letter-spacing: 0.04em;
          }

          .copy-btn:hover {
            background-color: #ffffff;
            border-color: #ffffff;
            color: #000000;
            transform: translateY(-1px);
          }

          .copy-btn:active {
            transform: scale(0.98);
          }

          .feed-url-input {
            flex: 1;
            min-width: 260px;
            background-color: #080808;
            border: 1px solid var(--border);
            color: var(--neutral);
            padding: 0.55rem 0.85rem;
            font-family: var(--font-mono);
            font-size: 0.75rem;
            outline: none;
            transition: border-color 0.15s ease;
          }

          .feed-url-input:focus {
            border-color: var(--accent);
            color: #ffffff;
          }

          .readers-hint {
            font-family: var(--font-mono);
            font-size: 0.7rem;
            color: var(--neutral-dark);
            margin-top: 0.85rem;
          }

          /* Posts Stream Section */
          .section-heading {
            font-family: var(--font-mono);
            font-size: 0.75rem;
            font-weight: 700;
            color: #ffffff;
            letter-spacing: 0.05em;
            text-transform: uppercase;
            border-bottom: 1px solid var(--border);
            padding-bottom: 0.5rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
          }

          .posts-list {
            display: flex;
            flex-direction: column;
            gap: 1.25rem;
          }

          .post-card {
            background-color: var(--card-bg);
            border: 1px solid var(--border);
            padding: 1.4rem 1.5rem;
            transition: border-color 0.2s ease, transform 0.2s ease;
            position: relative;
          }

          .post-card:hover {
            border-color: var(--accent);
            transform: translateX(4px);
          }

          .post-meta {
            font-family: var(--font-mono);
            font-size: 0.7rem;
            color: var(--neutral-dark);
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 0.6rem;
          }

          .category-tag {
            background-color: rgba(255, 69, 0, 0.1);
            color: var(--accent);
            border: 1px solid rgba(255, 69, 0, 0.3);
            padding: 0.15rem 0.45rem;
            font-weight: 600;
          }

          .post-title {
            font-size: 1.15rem;
            font-weight: 700;
            line-height: 1.25;
            letter-spacing: -0.02em;
            margin-bottom: 0.6rem;
          }

          .post-title a {
            color: #ffffff;
            text-decoration: none;
            transition: color 0.15s ease;
          }

          .post-title a:hover {
            color: var(--accent);
          }

          .post-desc {
            font-size: 0.85rem;
            color: var(--neutral);
            line-height: 1.55;
            margin-bottom: 1rem;
          }

          .post-action {
            font-family: var(--font-mono);
            font-size: 0.75rem;
            font-weight: 700;
          }

          .post-action a {
            color: var(--accent);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            transition: color 0.15s ease;
          }

          .post-action a:hover {
            color: #ffffff;
            text-decoration: underline;
          }

          /* Footer */
          footer {
            border-top: 1px solid var(--border);
            padding: 1.5rem 0;
            font-family: var(--font-mono);
            font-size: 0.7rem;
            color: var(--neutral-dark);
            text-align: center;
            width: 100%;
          }

          footer a {
            color: var(--neutral);
            text-decoration: none;
          }

          footer a:hover {
            color: var(--accent);
          }
        ]]></style>
      </head>
      <body>
        <!-- Shutter Curtain Element -->
        <div id="swiss-shutter" aria-hidden="true"></div>

        <div class="grid-backdrop"></div>

        <div class="container">
          <!-- Top Telemetry Navigation -->
          <nav class="telemetry-bar">
            <div>
              <span class="status-pulse"></span>
              <span>[FEED // SYNDICATION_v2.4]</span>
            </div>
            <div>
              <a href="/notes" id="back-notes-link" class="back-link" title="Return to Field Notes (or press ESC)">
                <span class="back-arrow">←</span>
                <span>BACK TO FIELD NOTES</span>
                <span class="esc-badge">ESC</span>
              </a>
            </div>
          </nav>

          <!-- Feed Header -->
          <header class="feed-header">
            <div class="feed-tag">
              <span>●</span>
              <span>TECHNICAL RSS DISPATCHES</span>
            </div>
            <h1 class="feed-title">
              <xsl:value-of select="/rss/channel/title"/>
            </h1>
            <p class="feed-desc">
              <xsl:value-of select="/rss/channel/description"/>
            </p>
          </header>

          <!-- Educational & Interactive Action Banner -->
          <aside class="education-card">
            <span class="edu-badge">[HOW_TO_SUBSCRIBE]</span>
            <h2 class="edu-heading">This is an RSS Feed (Web Syndication Stream)</h2>
            <p class="edu-text">
              RSS allows you to subscribe to new articles automatically without email newsletters or algorithmic social feeds.
              Copy this feed URL and add it to your preferred <strong>RSS reader</strong> (such as <strong>Feedly</strong>, <strong>NetNewsWire</strong>, <strong>Inoreader</strong>, or <strong>Readwise Reader</strong>) to get notified whenever a new technical spec is published.
            </p>

            <div class="action-group">
              <input type="text" id="feed-url-input" class="feed-url-input" readonly="readonly" value="https://reshandytaftazani.github.io/rss.xml" onclick="this.select()"/>
              <button type="button" id="copy-feed-btn" class="copy-btn">
                <span>[COPY FEED URL]</span>
              </button>
            </div>
            <div class="readers-hint">
              <span>TIP: Feed readers parse this exact page as standard RSS 2.0 XML.</span>
            </div>
          </aside>

          <!-- Articles Stream -->
          <main>
            <div class="section-heading">
              <span>LATEST TECHNICAL DISPATCHES</span>
              <span><xsl:value-of select="count(/rss/channel/item)"/> UNITS</span>
            </div>

            <div class="posts-list">
              <xsl:for-each select="/rss/channel/item">
                <article class="post-card">
                  <div class="post-meta">
                    <xsl:if test="category">
                      <span class="category-tag"><xsl:value-of select="category"/></span>
                      <span>•</span>
                    </xsl:if>
                    <span><xsl:value-of select="pubDate"/></span>
                  </div>

                  <h3 class="post-title">
                    <a href="{link}">
                      <xsl:value-of select="title"/>
                    </a>
                  </h3>

                  <p class="post-desc">
                    <xsl:value-of select="description"/>
                  </p>

                  <div class="post-action">
                    <a href="{link}">
                      <span>READ TECHNICAL SPEC ↗</span>
                    </a>
                  </div>
                </article>
              </xsl:for-each>
            </div>
          </main>
        </div>

        <footer>
          <div>
            DOC: RESHANDY_TAFTAZANI_RSS_SPEC // CS @ UNIVERSITAS INDONESIA // <a href="https://reshandytaftazani.github.io">reshandytaftazani.github.io</a>
          </div>
        </footer>

        <script><![CDATA[
          (function() {
            var shutter = document.getElementById("swiss-shutter");
            var isNavigating = false;
            var transitionType = sessionStorage.getItem("swiss_nav_transition");
            var isCovered = document.documentElement.classList.contains("swiss-shutter-covered");

            if (transitionType) {
              sessionStorage.removeItem("swiss_nav_transition");
            }

            // Function to reveal page (0% -> -100%) on entry
            function revealPage() {
              if (!shutter) return;
              document.documentElement.classList.remove("swiss-shutter-covered");
              shutter.style.display = "block";
              shutter.style.transform = "translate3d(0, 0, 0)";

              requestAnimationFrame(function() {
                setTimeout(function() {
                  shutter.style.transition = "transform 0.65s cubic-bezier(0.85, 0, 0.15, 1)";
                  shutter.style.transform = "translate3d(0, -100%, 0)";

                  function onRevealEnd() {
                    shutter.style.display = "none";
                    shutter.style.transition = "none";
                    shutter.style.transform = "translate3d(0, 100%, 0)";
                    shutter.removeEventListener("transitionend", onRevealEnd);
                  }
                  shutter.addEventListener("transitionend", onRevealEnd);
                }, 40);
              });
            }

            if (transitionType === "fast" || isCovered) {
              revealPage();
            }

            // Continuous upward wipe transition when navigating away
            function navigateWithCurtain(targetUrl) {
              if (isNavigating) return;
              isNavigating = true;

              // Pre-flag destination page to be covered before first paint (eliminates FOUC)
              sessionStorage.setItem("swiss_nav_transition", "fast");

              if (!shutter) {
                window.location.href = targetUrl;
                return;
              }

              shutter.style.display = "block";
              shutter.style.transform = "translate3d(0, 100%, 0)";
              void shutter.offsetHeight; // force reflow

              shutter.style.transition = "transform 0.42s cubic-bezier(0.85, 0, 0.15, 1)";
              shutter.style.transform = "translate3d(0, 0, 0)";

              var navigated = false;
              function finishNav() {
                if (navigated) return;
                navigated = true;
                window.location.href = targetUrl;
              }

              shutter.addEventListener("transitionend", function onCovered() {
                shutter.removeEventListener("transitionend", onCovered);
                finishNav();
              });

              setTimeout(finishNav, 480);
            }

            // Back to Notes handler
            function goBackToNotes(e) {
              if (e) e.preventDefault();
              navigateWithCurtain("/notes");
            }

            var backBtn = document.getElementById("back-notes-link");
            if (backBtn) {
              backBtn.addEventListener("click", goBackToNotes);
            }

            // Keyboard ESC listener
            window.addEventListener("keydown", function(e) {
              if (e.key === "Escape" || e.key === "Esc") {
                e.preventDefault();
                goBackToNotes();
              }
            });

            // Intercept internal article links
            document.querySelectorAll("a[href]").forEach(function(link) {
              if (link.id === "back-notes-link") return;
              link.addEventListener("click", function(e) {
                var href = link.getAttribute("href");
                if (!href || href.startsWith("#") || href.startsWith("mailto:") || link.target === "_blank") return;
                try {
                  var target = new URL(link.href, window.location.origin);
                  if (target.origin === window.location.origin) {
                    e.preventDefault();
                    navigateWithCurtain(target.href);
                  }
                } catch (err) {}
              });
            });

            // Feed URL Copying
            var copyBtn = document.getElementById("copy-feed-btn");
            var input = document.getElementById("feed-url-input");
            if (input) {
              input.value = window.location.href.split("?")[0];
            }

            if (copyBtn && input) {
              copyBtn.addEventListener("click", function() {
                var url = input.value;
                if (navigator.clipboard && window.isSecureContext) {
                  navigator.clipboard.writeText(url).then(showCopied).catch(fallback);
                } else {
                  fallback();
                }

                function showCopied() {
                  var orig = copyBtn.innerHTML;
                  copyBtn.innerHTML = "<span>COPIED TO CLIPBOARD ✓</span>";
                  copyBtn.style.backgroundColor = "#ffffff";
                  copyBtn.style.borderColor = "#ffffff";
                  setTimeout(function() {
                    copyBtn.innerHTML = orig;
                    copyBtn.style.backgroundColor = "";
                    copyBtn.style.borderColor = "";
                  }, 2500);
                }

                function fallback() {
                  input.focus();
                  input.select();
                  try {
                    document.execCommand("copy");
                    showCopied();
                  } catch (e) {
                    console.error("Fallback copy failed", e);
                  }
                }
              });
            }

            // Bfcache handling
            window.addEventListener("pageshow", function(e) {
              if (e.persisted) {
                document.documentElement.classList.remove("swiss-shutter-covered");
                if (shutter) {
                  shutter.style.display = "none";
                  shutter.style.transform = "translate3d(0, 100%, 0)";
                }
                isNavigating = false;
              }
            });
          })();
        ]]></script>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
