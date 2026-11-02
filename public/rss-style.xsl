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
            flex-wrap: wrap;
            gap: 0.75rem;
          }

          .telemetry-left {
            display: flex;
            align-items: center;
            gap: 0.4rem;
          }

          .telemetry-right {
            display: flex;
            align-items: center;
            gap: 0.5rem;
          }

          .nav-shortcut-btn {
            background-color: #141414;
            color: #cccccc;
            border: 1px solid var(--border);
            padding: 0.3rem 0.55rem;
            font-family: var(--font-mono);
            font-size: 0.7rem;
            font-weight: 700;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            border-radius: 2px;
            transition: all 0.15s ease;
            user-select: none;
          }

          .nav-shortcut-btn:hover {
            color: #ffffff;
            border-color: var(--accent);
            background-color: #1a1a1a;
          }

          .nav-key {
            font-size: 0.625rem;
            color: var(--accent);
            background-color: #0a0a0a;
            border: 1px solid #333;
            padding: 0.05rem 0.25rem;
            border-radius: 2px;
          }

          .nav-shortcut-btn:hover .nav-key {
            background-color: var(--accent);
            color: #000;
            border-color: var(--accent);
          }

          .telemetry-bar a.back-link {
            color: var(--neutral);
            text-decoration: none;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.3rem 0.65rem;
            background-color: #121212;
            border: 1px solid var(--border);
            border-radius: 2px;
            transition: all 0.15s ease;
            cursor: pointer;
            user-select: none;
            font-size: 0.7rem;
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

          /* ==========================================================================
             COMMAND PALETTE (CTRL+K) STYLES & KEYFRAMES
             ========================================================================== */
          @keyframes cmdBackdropFadeIn {
            from {
              opacity: 0;
              backdrop-filter: blur(0px);
              -webkit-backdrop-filter: blur(0px);
            }
            to {
              opacity: 1;
              backdrop-filter: blur(8px);
              -webkit-backdrop-filter: blur(8px);
            }
          }

          @keyframes cmdBackdropFadeOut {
            from {
              opacity: 1;
              backdrop-filter: blur(8px);
              -webkit-backdrop-filter: blur(8px);
            }
            to {
              opacity: 0;
              backdrop-filter: blur(0px);
              -webkit-backdrop-filter: blur(0px);
            }
          }

          @keyframes cmdModalEnter {
            0% {
              opacity: 0;
              transform: scale(0.93) translateY(-20px);
            }
            40% {
              opacity: 0.85;
            }
            100% {
              opacity: 1;
              transform: scale(1) translateY(0);
            }
          }

          @keyframes cmdModalExit {
            0% {
              opacity: 1;
              transform: scale(1) translateY(0);
            }
            50% {
              opacity: 0.4;
            }
            100% {
              opacity: 0;
              transform: scale(0.95) translateY(-16px);
            }
          }

          .swiss-cmd-overlay {
            position: fixed;
            inset: 0;
            z-index: 99998;
            background: rgba(0, 0, 0, 0.8);
            backdrop-filter: blur(4px);
            -webkit-backdrop-filter: blur(4px);
            display: flex;
            align-items: flex-start;
            justify-content: center;
            overflow-y: auto;
            padding: 1rem;
            font-family: var(--font-mono);
          }

          @media (min-width: 640px) {
            .swiss-cmd-overlay {
              padding: 1.5rem;
            }
          }

          @media (min-width: 1024px) {
            .swiss-cmd-overlay {
              padding: 3rem;
            }
          }

          .swiss-cmd-overlay.is-open {
            animation: cmdBackdropFadeIn 0.25s ease-out forwards;
          }

          .swiss-cmd-overlay.is-open .swiss-cmd-modal {
            animation: cmdModalEnter 0.28s cubic-bezier(0.16, 1, 0.3, 1) forwards;
          }

          .swiss-cmd-overlay.is-closing {
            animation: cmdBackdropFadeOut 0.2s ease-in forwards;
          }

          .swiss-cmd-overlay.is-closing .swiss-cmd-modal {
            animation: cmdModalExit 0.2s cubic-bezier(0.4, 0, 1, 1) forwards;
          }

          .swiss-cmd-modal {
            position: relative;
            width: 100%;
            max-width: 42rem;
            margin: 2rem auto 0;
            background-color: #0f0f0f;
            border: 1px solid #2a2a2a;
            box-shadow: 0 25px 60px rgba(0, 0, 0, 0.9);
            font-size: 0.75rem;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            will-change: transform, opacity;
          }

          @media (min-width: 640px) {
            .swiss-cmd-modal {
              margin-top: 4rem;
            }
          }

          .swiss-cmd-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.85rem 1rem;
            background-color: #141414;
            border-bottom: 1px solid #222;
          }

          .cmd-prompt {
            color: var(--accent);
            font-weight: 700;
            font-size: 0.9rem;
          }

          .swiss-cmd-header input {
            flex: 1;
            background: transparent;
            border: none;
            outline: none;
            color: #ffffff;
            font-family: var(--font-mono);
            font-size: 0.8rem;
          }

          .swiss-cmd-header input::placeholder {
            color: #666666;
          }

          .swiss-cmd-results {
            max-height: 55vh;
            overflow-y: auto;
            padding: 0.5rem;
            display: flex;
            flex-direction: column;
            gap: 0.2rem;
          }

          .swiss-cmd-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0.6rem 0.85rem;
            border-radius: 2px;
            cursor: pointer;
            color: #cccccc;
            transition: background-color 0.1s ease;
          }

          .swiss-cmd-item:hover,
          .swiss-cmd-item.selected {
            background-color: #1e1e1e;
            color: #ffffff;
          }

          .swiss-cmd-item.selected .cmd-item-label {
            color: var(--accent);
          }

          .cmd-item-left {
            display: flex;
            align-items: center;
            gap: 0.6rem;
            overflow: hidden;
          }

          .cmd-item-icon {
            color: var(--accent);
            font-size: 0.85rem;
            width: 14px;
            text-align: center;
          }

          .cmd-item-label {
            font-size: 0.75rem;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
          }

          .cmd-item-badge {
            font-size: 0.625rem;
            color: #777;
            background-color: #080808;
            border: 1px solid #262626;
            padding: 0.1rem 0.35rem;
            border-radius: 2px;
          }

          .swiss-cmd-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0.5rem 1rem;
            background-color: #0a0a0a;
            border-top: 1px solid #1f1f1f;
            font-size: 0.625rem;
            color: #777;
          }

          .cmd-keys {
            display: flex;
            gap: 0.75rem;
          }

          .cmd-keys kbd {
            color: #aaa;
          }

          .cmd-telemetry {
            display: flex;
            align-items: center;
            gap: 0.35rem;
            color: var(--accent);
            font-weight: 700;
          }

          /* ==========================================================================
             UNIX TERMINAL DRAWER (`) STYLES
             ========================================================================== */
          .term-scrim {
            position: fixed;
            inset: 0;
            z-index: 99990;
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(2px);
            -webkit-backdrop-filter: blur(2px);
            opacity: 0;
            pointer-events: none;
            transition: opacity 0.3s ease;
          }

          .term-scrim.is-open {
            opacity: 1;
            pointer-events: auto;
          }

          .term-drawer {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            z-index: 99992;
            height: 48vh;
            background-color: #08090a;
            border-top: 2px solid var(--accent);
            box-shadow: 0 -16px 50px rgba(0, 0, 0, 0.95);
            font-family: var(--font-mono);
            font-size: 0.75rem;
            display: flex;
            flex-direction: column;
            transform: translate3d(0, 100%, 0);
            transition: transform 0.3s cubic-bezier(0.16, 1, 0.3, 1);
            will-change: transform;
          }

          .term-drawer.is-open {
            transform: translate3d(0, 0, 0);
          }

          @media (prefers-reduced-motion: reduce) {
            .swiss-cmd-overlay.is-open .swiss-cmd-modal,
            .swiss-cmd-overlay.is-closing .swiss-cmd-modal {
              animation: none !important;
              transform: none !important;
            }
            .term-drawer {
              transform: none !important;
              transition: opacity 0.2s ease-out !important;
              opacity: 0;
            }
            .term-drawer.is-open {
              opacity: 1;
            }
          }

          .swiss-cmd-results::-webkit-scrollbar,
          .term-screen::-webkit-scrollbar {
            width: 5px;
          }
          .swiss-cmd-results::-webkit-scrollbar-track,
          .term-screen::-webkit-scrollbar-track {
            background: #0d0d0d;
          }
          .swiss-cmd-results::-webkit-scrollbar-thumb,
          .term-screen::-webkit-scrollbar-thumb {
            background: #2a2a2a;
            border-radius: 2px;
          }
          .swiss-cmd-results::-webkit-scrollbar-thumb:hover,
          .term-screen::-webkit-scrollbar-thumb:hover {
            background: var(--accent);
          }

          .term-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0.5rem 0.85rem;
            background-color: #0e1113;
            border-bottom: 1px solid #1c2227;
            user-select: none;
          }

          .term-title {
            display: flex;
            align-items: center;
            gap: 0.6rem;
          }

          .term-traffic-dots {
            display: flex;
            align-items: center;
            gap: 0.35rem;
          }

          .traffic-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
          }

          .traffic-dot.red { background-color: #ff5f56; }
          .traffic-dot.yellow { background-color: #ffbd2e; }
          .traffic-dot.green { background-color: #27c93f; }

          .term-name {
            font-weight: 700;
            color: #ffffff;
            font-size: 0.75rem;
          }

          .term-badge {
            font-size: 0.625rem;
            font-weight: 700;
            color: #34d399;
            background-color: rgba(6, 78, 59, 0.4);
            border: 1px solid rgba(52, 211, 153, 0.4);
            padding: 0.1rem 0.35rem;
            border-radius: 2px;
          }

          .term-actions {
            display: flex;
            gap: 0.4rem;
          }

          .term-action-btn {
            background-color: #14181b;
            color: #888888;
            border: 1px solid #2a2a2a;
            padding: 0.2rem 0.5rem;
            font-family: var(--font-mono);
            font-size: 0.625rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.15s ease;
          }

          .term-action-btn:hover {
            color: #ffffff;
            border-color: var(--accent);
          }

          .term-screen {
            flex: 1;
            padding: 0.85rem 1rem;
            overflow-y: auto;
            background-color: #08090a;
            background-image: linear-gradient(rgba(14, 18, 22, 0) 50%, rgba(0, 0, 0, 0.3) 50%);
            background-size: 100% 4px;
            color: #d1d5db;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
          }

          .term-output {
            display: flex;
            flex-direction: column;
            gap: 0.35rem;
            white-space: pre-wrap;
            line-height: 1.45;
          }

          .term-line-output {
            color: #9ca3af;
          }

          .term-line-command {
            color: #ffffff;
            font-weight: 700;
          }

          .term-line-accent {
            color: var(--accent);
          }

          .term-input-line {
            display: flex;
            align-items: center;
            position: relative;
            margin-top: 0.25rem;
          }

          .term-user-prompt {
            color: var(--accent);
            font-weight: 700;
            margin-right: 0.35rem;
          }

          .term-cursor {
            display: inline-block;
            width: 8px;
            height: 14px;
            background-color: var(--accent);
            animation: term-blink 1s infinite;
          }

          @keyframes term-blink {
            0%, 49% { opacity: 1; }
            50%, 100% { opacity: 0; }
          }

          .term-native-input {
            position: absolute;
            inset: 0;
            opacity: 0;
            width: 100%;
            height: 100%;
            cursor: text;
          }

          .term-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0.4rem 0.85rem;
            background-color: #0b0e10;
            border-top: 1px solid #181d21;
            font-size: 0.625rem;
            color: #777;
            user-select: none;
            overflow-x: auto;
          }

          .term-quick-pills {
            display: flex;
            align-items: center;
            gap: 0.35rem;
          }

          .quick-label {
            color: #555;
            font-weight: 700;
          }

          .term-pill {
            background-color: #121619;
            color: #aaa;
            border: 1px solid #222;
            padding: 0.15rem 0.4rem;
            font-family: var(--font-mono);
            font-size: 0.625rem;
            font-weight: 700;
            cursor: pointer;
            border-radius: 2px;
            transition: all 0.15s ease;
          }

          .term-pill:hover {
            background-color: var(--accent);
            color: #000;
            border-color: var(--accent);
          }

          .term-shortcuts {
            display: flex;
            gap: 0.5rem;
            color: #666;
          }

          .term-shortcuts kbd {
            color: #999;
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
            <div class="telemetry-left">
              <span class="status-pulse"></span>
              <span>[FEED // SYNDICATION_v2.4]</span>
            </div>
            <div class="telemetry-right">
              <button type="button" id="open-cmd-btn" class="nav-shortcut-btn" title="Open Command Palette (Ctrl+K)">
                <span>CMD</span>
                <span class="nav-key">CTRL+K</span>
              </button>
              <button type="button" id="open-term-btn" class="nav-shortcut-btn" title="Open UNIX Terminal (`)">
                <span>TERM</span>
                <span class="nav-key">`</span>
              </button>
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
              <span>TIP: Feed readers parse this exact page as standard RSS 2.0 XML. Press Ctrl+K for commands or ` for terminal.</span>
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

        <!-- Global Command Palette Modal -->
        <div id="swiss-command-dialog" class="swiss-cmd-overlay" style="display: none;" role="dialog" aria-modal="true" aria-label="Command Palette">
          <div id="swiss-command-container" class="swiss-cmd-modal">
            <div class="swiss-cmd-header">
              <span class="cmd-prompt">&gt;</span>
              <input type="text" id="command-input" placeholder="Type a command or page name... (ESC to close)" autocomplete="off" spellcheck="false" />
              <kbd class="esc-badge">ESC</kbd>
            </div>
            <div id="command-results" class="swiss-cmd-results" role="listbox"></div>
            <div class="swiss-cmd-footer">
              <div class="cmd-keys">
                <span><kbd>↑↓</kbd> NAVIGATE</span>
                <span><kbd>↵</kbd> EXECUTE</span>
              </div>
              <div class="cmd-telemetry">
                <span class="status-pulse"></span>
                <span>SWISS CLI // v2.4</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Global Interactive UNIX Terminal Drawer -->
        <div id="terminal-scrim" class="term-scrim" style="display: none;" aria-hidden="true"></div>
        <aside id="terminal-drawer" class="term-drawer" style="display: none;" role="region" aria-label="Interactive UNIX Kernel Terminal Drawer">
          <div class="term-header">
            <div class="term-title">
              <div class="term-traffic-dots">
                <span class="traffic-dot red"></span>
                <span class="traffic-dot yellow"></span>
                <span class="traffic-dot green"></span>
              </div>
              <span class="cmd-prompt">&gt;</span>
              <span class="term-name">[TERMINAL // RESHANDY_KERNEL_v2.4]</span>
              <span class="term-badge">IPC: CONNECTED</span>
            </div>
            <div class="term-actions">
              <button type="button" id="term-btn-clear" class="term-action-btn">[CLEAR]</button>
              <button type="button" id="term-btn-close" class="term-action-btn">[CLOSE]</button>
            </div>
          </div>
          <div id="terminal-screen" class="term-screen">
            <div id="terminal-output" class="term-output">
              <div class="term-line-accent">RESHANDY_OS v2.4 (x86_64-darwin-kernel) // UNIX REPL EMULATOR</div>
              <div class="term-line-output">Type 'help' for available commands, 'status' for cluster state, or 'cat modelarena'.</div>
            </div>
            <div class="term-input-line">
              <span class="term-user-prompt">reshandy@kernel:~$ </span>
              <span id="term-text"></span>
              <span class="term-cursor"> </span>
              <input type="text" id="terminal-input" class="term-native-input" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" aria-label="Terminal Command Prompt" />
            </div>
          </div>
          <div class="term-footer">
            <div class="term-quick-pills">
              <span class="quick-label">QUICK:</span>
              <button type="button" class="term-pill" data-cmd="help">help</button>
              <button type="button" class="term-pill" data-cmd="whoami">whoami</button>
              <button type="button" class="term-pill" data-cmd="cat modelarena">cat modelarena</button>
              <button type="button" class="term-pill" data-cmd="cat finance-tracker">cat finance-tracker</button>
              <button type="button" class="term-pill" data-cmd="status">status</button>
              <button type="button" class="term-pill" data-cmd="clear">clear</button>
            </div>
            <div class="term-shortcuts">
              <span><kbd>`</kbd> toggle</span>
              <span>•</span>
              <span><kbd>ESC</kbd> close</span>
            </div>
          </div>
        </aside>

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

              sessionStorage.setItem("swiss_nav_transition", "fast");

              // Immediately dismiss overlays behind curtain
              document.body.style.overflow = "";
              if (cmdDialog) {
                cmdDialog.classList.remove("is-open", "is-closing");
                cmdDialog.style.display = "none";
              }
              if (termDrawer) {
                termDrawer.classList.remove("is-open");
                termDrawer.style.display = "none";
              }
              if (termScrim) {
                termScrim.classList.remove("is-open");
                termScrim.style.display = "none";
              }

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

            // Helper to check active overlay
            function isAnyOverlayOpen() {
              var cmd = document.getElementById("swiss-command-dialog");
              var isCmd = cmd && (cmd.classList.contains("is-open") || cmd.style.display !== "none");
              var term = document.getElementById("terminal-drawer");
              var isTerm = term && (term.classList.contains("is-open") || term.style.display !== "none");
              return Boolean(isCmd || isTerm);
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

            // ==========================================================================
            // COMMAND PALETTE LOGIC
            // ==========================================================================
            var cmdDialog = document.getElementById("swiss-command-dialog");
            var cmdInput = document.getElementById("command-input");
            var cmdResults = document.getElementById("command-results");
            var cmdSelectedIndex = 0;
            var cmdCloseTimeout = null;

            var COMMANDS = [
              { label: "Go to Home / Selected Works", shortcut: "G H", icon: "⌂", action: function() { navigateWithCurtain("/"); } },
              { label: "Open Engineering Directory & Archive", shortcut: "G P", icon: "⊞", action: function() { navigateWithCurtain("/projects"); } },
              { label: "Open Technical Field Notes & Journal", shortcut: "G N", icon: "§", action: function() { navigateWithCurtain("/notes"); } },
              { label: "View Printable Swiss Technical CV", shortcut: "CV", icon: "↗", action: function() { navigateWithCurtain("/resume"); } },
              { label: "Open Interactive UNIX Terminal", shortcut: "TERM", icon: ">_", action: function() { closeCommandPalette(); openTerminal(); } },
              { label: "Copy Institutional Email (UI)", shortcut: "COPY", icon: "@", action: function() { copyText("reshandy.taftazani@ui.ac.id", "Email copied: reshandy.taftazani@ui.ac.id"); } },
              { label: "Copy RSS Feed URL", shortcut: "RSS", icon: "↗", action: function() { copyText(window.location.href.split("?")[0], "Feed URL copied to clipboard"); } },
              { label: "Open GitHub Profile (@reshandytaftazani)", shortcut: "EXT ↗", icon: "↗", action: function() { window.open("https://github.com/reshandytaftazani", "_blank"); } },
              { label: "Open LinkedIn Network Profile", shortcut: "EXT ↗", icon: "↗", action: function() { window.open("https://linkedin.com/in/reshandy-taftazani-aulya", "_blank"); } },
              { label: "Field Note: POSIX Signal Traps in Async Python", shortcut: "NOTE", icon: "§", action: function() { navigateWithCurtain("/notes/posix-signals-async-python"); } },
              { label: "Field Note: Eliminating Lookahead Bias in Rolling Splits", shortcut: "NOTE", icon: "§", action: function() { navigateWithCurtain("/notes/eliminating-lookahead-bias"); } },
              { label: "Field Note: Hexagonal Architecture for ML Feature Stores", shortcut: "NOTE", icon: "§", action: function() { navigateWithCurtain("/notes/hexagonal-architecture-feature-stores"); } }
            ];

            function isCommandPaletteOpen() {
              return Boolean(cmdDialog && !cmdDialog.classList.contains("is-closing") && (cmdDialog.classList.contains("is-open") || cmdDialog.style.display !== "none"));
            }

            function openCommandPalette() {
              if (isTerminalOpen()) closeTerminal();
              if (cmdCloseTimeout) {
                clearTimeout(cmdCloseTimeout);
                cmdCloseTimeout = null;
              }
              document.body.style.overflow = "hidden";
              cmdDialog.style.display = "flex";
              cmdDialog.classList.remove("is-closing");
              cmdDialog.classList.add("is-open");

              cmdInput.value = "";
              cmdSelectedIndex = 0;
              renderCommands("");
              setTimeout(function() { cmdInput.focus(); }, 30);
            }

            function closeCommandPalette() {
              if (!cmdDialog || cmdDialog.style.display === "none" || cmdDialog.classList.contains("is-closing")) return;
              cmdDialog.classList.remove("is-open");
              cmdDialog.classList.add("is-closing");
              document.body.style.overflow = "";

              if (cmdCloseTimeout) clearTimeout(cmdCloseTimeout);
              cmdCloseTimeout = setTimeout(function() {
                cmdDialog.style.display = "none";
                cmdDialog.classList.remove("is-closing");
                cmdCloseTimeout = null;
              }, 200);
            }

            function renderCommands(filter) {
              cmdResults.innerHTML = "";
              var query = filter.toLowerCase().trim();
              var matches = COMMANDS.filter(function(c) {
                return !query || c.label.toLowerCase().indexOf(query) !== -1 || c.shortcut.toLowerCase().indexOf(query) !== -1;
              });

              if (matches.length === 0) {
                var empty = document.createElement("div");
                empty.style.padding = "1rem";
                empty.style.textAlign = "center";
                empty.style.color = "#666";
                empty.textContent = "No matching commands found.";
                cmdResults.appendChild(empty);
                return;
              }

              if (cmdSelectedIndex >= matches.length) cmdSelectedIndex = 0;

              matches.forEach(function(cmd, idx) {
                var item = document.createElement("div");
                item.className = "swiss-cmd-item" + (idx === cmdSelectedIndex ? " selected" : "");
                item.innerHTML = '<div class="cmd-item-left"><span class="cmd-item-icon">' + cmd.icon + '</span><span class="cmd-item-label">' + cmd.label + '</span></div><span class="cmd-item-badge">' + cmd.shortcut + '</span>';
                item.addEventListener("click", function() {
                  closeCommandPalette();
                  cmd.action();
                });
                cmdResults.appendChild(item);
              });
            }

            function executeSelectedCommand() {
              var query = cmdInput.value.toLowerCase().trim();
              var matches = COMMANDS.filter(function(c) {
                return !query || c.label.toLowerCase().indexOf(query) !== -1 || c.shortcut.toLowerCase().indexOf(query) !== -1;
              });
              if (matches[cmdSelectedIndex]) {
                closeCommandPalette();
                matches[cmdSelectedIndex].action();
              }
            }

            if (cmdInput) {
              cmdInput.addEventListener("input", function() {
                cmdSelectedIndex = 0;
                renderCommands(cmdInput.value);
              });
            }

            if (cmdDialog) {
              cmdDialog.addEventListener("click", function(e) {
                if (e.target === cmdDialog) closeCommandPalette();
              });
            }

            var openCmdBtn = document.getElementById("open-cmd-btn");
            if (openCmdBtn) openCmdBtn.addEventListener("click", openCommandPalette);

            // ==========================================================================
            // TERMINAL DRAWER LOGIC
            // ==========================================================================
            var termDrawer = document.getElementById("terminal-drawer");
            var termScrim = document.getElementById("terminal-scrim");
            var termScreen = document.getElementById("terminal-screen");
            var termOutput = document.getElementById("terminal-output");
            var termInput = document.getElementById("terminal-input");
            var termText = document.getElementById("term-text");
            var termCloseTimeout = null;

            function isTerminalOpen() {
              return Boolean(termDrawer && (termDrawer.classList.contains("is-open") || termDrawer.style.display !== "none"));
            }

            function openTerminal() {
              if (isCommandPaletteOpen()) closeCommandPalette();
              if (termCloseTimeout) {
                clearTimeout(termCloseTimeout);
                termCloseTimeout = null;
              }
              termScrim.style.display = "block";
              termDrawer.style.display = "flex";
              void termDrawer.offsetHeight;
              termScrim.classList.add("is-open");
              termDrawer.classList.add("is-open");

              if (termInput) {
                termInput.value = "";
                termText.textContent = "";
                setTimeout(function() { termInput.focus(); }, 30);
              }
            }

            function closeTerminal() {
              if (!termDrawer) return;
              termScrim.classList.remove("is-open");
              termDrawer.classList.remove("is-open");
              if (termCloseTimeout) clearTimeout(termCloseTimeout);
              termCloseTimeout = setTimeout(function() {
                termScrim.style.display = "none";
                termDrawer.style.display = "none";
                termCloseTimeout = null;
              }, 300);
            }

            var openTermBtn = document.getElementById("open-term-btn");
            if (openTermBtn) openTermBtn.addEventListener("click", openTerminal);

            var termBtnClose = document.getElementById("term-btn-close");
            if (termBtnClose) termBtnClose.addEventListener("click", closeTerminal);

            var termBtnClear = document.getElementById("term-btn-clear");
            if (termBtnClear) {
              termBtnClear.addEventListener("click", function() {
                termOutput.innerHTML = "";
              });
            }

            if (termScrim) {
              termScrim.addEventListener("click", closeTerminal);
            }

            // Quick pills click
            document.querySelectorAll(".term-pill").forEach(function(pill) {
              pill.addEventListener("click", function() {
                var cmd = pill.getAttribute("data-cmd");
                if (cmd) executeTerminalCommand(cmd);
              });
            });

            if (termInput) {
              termInput.addEventListener("input", function() {
                termText.textContent = termInput.value;
              });

              termInput.addEventListener("keydown", function(e) {
                if (e.key === "Enter") {
                  var cmd = termInput.value.trim();
                  termInput.value = "";
                  termText.textContent = "";
                  if (cmd) executeTerminalCommand(cmd);
                }
              });
            }

            if (termScreen) {
              termScreen.addEventListener("click", function() {
                if (termInput) termInput.focus();
              });
            }

            function executeTerminalCommand(cmd) {
              appendTerminalLine("reshandy@kernel:~$ " + cmd, "term-line-command");
              var lower = cmd.toLowerCase().trim();

              if (lower === "help") {
                appendTerminalLine("Available commands:\n  help                 Display system command dictionary\n  whoami               Identity and verified technical background\n  status               Cluster telemetry & active R&D nodes\n  cat [project]        Read technical architecture (modelarena, finance-tracker, savebite)\n  notes                Open field notes repository\n  cv                   Open Swiss Technical CV\n  clear                Clear output buffer\n  exit                 Close terminal drawer", "term-line-output");
              } else if (lower === "whoami") {
                appendTerminalLine("RESHANDY TAFTAZANI AULYA\nUndergraduate Computer Science @ Universitas Indonesia (Fasilkom UI, 2025)\nFocus: Machine Learning Engineering (MLE), Zero Data Leakage Systems & Distributed Runtimes.", "term-line-output");
              } else if (lower === "status") {
                appendTerminalLine("[SYSTEM_TELEMETRY // RESHANDY_KERNEL_v2.4]\nSTATUS: ALL SYSTEMS NOMINAL\nACTIVE_NODES: 3 (ModelArena, FinanceTracker, SaveBite)\nINVARIANTS: ZERO_LEAKAGE [VERIFIED] // ACID_LEDGER [VERIFIED]", "term-line-accent");
              } else if (lower === "cat modelarena") {
                appendTerminalLine("MODELARENA (Dynamic Resource Allocation & Multi-Agent RL Training):\n- Architected decoupled agent workers and central tournament arbiter over IPC shared memory\n- Accelerated high-learning models with up to +40% dynamic memory allocation", "term-line-output");
              } else if (lower === "cat finance-tracker") {
                appendTerminalLine("FINANCE TRACKER (Defensive Personal Accounting Engine & Ledger):\n- Strict double-entry ledger invariants ($0.00 discrepancy guarantee) using fixed-point arithmetic\n- SQLite WAL mode + FastAPI sustaining sub-5ms queries across 50,000+ transactions", "term-line-output");
              } else if (lower === "cat savebite") {
                appendTerminalLine("SAVEBITE (Surplus Food Rescue & Distribution Platform):\n- REST backend coordinating donors, NGOs, and couriers with real-time expiration window tracking\n- Django REST Framework + PostgreSQL + Flutter client integration", "term-line-output");
              } else if (lower === "clear") {
                termOutput.innerHTML = "";
              } else if (lower === "notes") {
                navigateWithCurtain("/notes");
              } else if (lower === "cv") {
                navigateWithCurtain("/resume");
              } else if (lower === "exit") {
                closeTerminal();
              } else {
                appendTerminalLine("Command not recognized: '" + cmd + "'. Type 'help' for command directory.", "term-line-output");
              }

              if (termScreen) {
                termScreen.scrollTop = termScreen.scrollHeight;
              }
            }

            function appendTerminalLine(text, className) {
              var div = document.createElement("div");
              div.className = className || "term-line-output";
              div.textContent = text;
              termOutput.appendChild(div);
            }

            function copyText(str, successMsg) {
              if (navigator.clipboard && window.isSecureContext) {
                navigator.clipboard.writeText(str).then(function() { alertBanner(successMsg); });
              } else {
                alertBanner(str);
              }
            }

            function alertBanner(msg) {
              var banner = document.createElement("div");
              banner.style.position = "fixed";
              banner.style.bottom = "20px";
              banner.style.right = "20px";
              banner.style.zIndex = "999999";
              banner.style.backgroundColor = "var(--accent)";
              banner.style.color = "#000";
              banner.style.fontFamily = "var(--font-mono)";
              banner.style.fontWeight = "bold";
              banner.style.fontSize = "0.75rem";
              banner.style.padding = "0.5rem 1rem";
              banner.style.borderRadius = "2px";
              banner.style.boxShadow = "0 4px 12px rgba(0,0,0,0.5)";
              banner.textContent = msg;
              document.body.appendChild(banner);
              setTimeout(function() { banner.remove(); }, 2500);
            }

            // ==========================================================================
            // GLOBAL KEYBOARD SHORTCUTS
            // ==========================================================================
            window.addEventListener("keydown", function(e) {
              // 1. Command Palette: Ctrl+K or Cmd+K
              if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === "k") {
                e.preventDefault();
                e.stopPropagation();
                if (isCommandPaletteOpen()) {
                  closeCommandPalette();
                } else {
                  openCommandPalette();
                }
                return;
              }

              // 2. Terminal Drawer: Backtick (` / ~) or Ctrl+J
              var isBacktick = e.key === "`" || e.key === "~" || e.code === "Backquote";
              var isCtrlJ = (e.ctrlKey || e.metaKey) && e.key.toLowerCase() === "j";
              if (isBacktick || isCtrlJ) {
                // If focus is inside command palette input, let normal typing happen
                if (isCommandPaletteOpen()) return;
                
                // If focus is inside terminal input and not empty, let typing happen
                if (isTerminalOpen() && isBacktick && termInput && termInput.value !== "") return;

                e.preventDefault();
                e.stopPropagation();
                if (isTerminalOpen()) {
                  closeTerminal();
                } else {
                  openTerminal();
                }
                return;
              }

              // 3. Inside Open Command Palette: Navigation & Execution
              if (isCommandPaletteOpen()) {
                if (e.key === "ArrowDown") {
                  e.preventDefault();
                  var items = cmdResults.querySelectorAll(".swiss-cmd-item");
                  if (items.length > 0) {
                    cmdSelectedIndex = (cmdSelectedIndex + 1) % items.length;
                    renderCommands(cmdInput.value);
                  }
                  return;
                }
                if (e.key === "ArrowUp") {
                  e.preventDefault();
                  var items = cmdResults.querySelectorAll(".swiss-cmd-item");
                  if (items.length > 0) {
                    cmdSelectedIndex = (cmdSelectedIndex - 1 + items.length) % items.length;
                    renderCommands(cmdInput.value);
                  }
                  return;
                }
                if (e.key === "Enter") {
                  e.preventDefault();
                  executeSelectedCommand();
                  return;
                }
              }

              // 4. Escape Key Handling (STRICT HIERARCHY)
              if (e.key === "Escape" || e.key === "Esc") {
                if (isAnyOverlayOpen()) {
                  e.preventDefault();
                  e.stopPropagation();
                  e.stopImmediatePropagation();
                  if (isCommandPaletteOpen()) closeCommandPalette();
                  if (isTerminalOpen()) closeTerminal();
                  return;
                }
                // No overlays open: navigate back to /notes
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
