#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./lib/common.sh
source "${SCRIPT_DIR}/lib/common.sh"

TARGET_DIR="${1:-apps/web-static}"

require_missing_path "$TARGET_DIR"
require_command mkdir

info "Bootstrapping static site into $TARGET_DIR"

mkdir -p "$TARGET_DIR"

cat <<'EOF' > "$TARGET_DIR/index.html"
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Static App</title>
    <meta
      name="description"
      content="Minimal static frontend created from the template bootstrap."
    />
    <style>
      :root {
        color-scheme: light;
        --bg: #f7f5ef;
        --fg: #14110f;
        --muted: #6b625b;
        --card: rgba(255, 255, 255, 0.88);
        --accent: #c5602d;
        --border: rgba(20, 17, 15, 0.1);
      }

      * {
        box-sizing: border-box;
      }

      body {
        margin: 0;
        min-height: 100vh;
        font-family: "Iowan Old Style", "Palatino Linotype", "Book Antiqua", serif;
        color: var(--fg);
        background:
          radial-gradient(circle at top, rgba(197, 96, 45, 0.18), transparent 32%),
          linear-gradient(180deg, #fbfaf6 0%, var(--bg) 100%);
      }

      main {
        width: min(720px, calc(100% - 2rem));
        margin: 0 auto;
        padding: 5rem 0 4rem;
      }

      .eyebrow {
        margin: 0 0 1rem;
        font-size: 0.85rem;
        letter-spacing: 0.16em;
        text-transform: uppercase;
        color: var(--accent);
      }

      .card {
        padding: 2rem;
        border: 1px solid var(--border);
        border-radius: 24px;
        background: var(--card);
        backdrop-filter: blur(12px);
        box-shadow: 0 18px 50px rgba(20, 17, 15, 0.08);
      }

      h1 {
        margin: 0;
        font-size: clamp(2.5rem, 6vw, 4.5rem);
        line-height: 0.95;
      }

      p {
        margin: 1.25rem 0 0;
        max-width: 38rem;
        font-size: 1.05rem;
        line-height: 1.6;
        color: var(--muted);
      }

      .actions {
        display: flex;
        flex-wrap: wrap;
        gap: 0.75rem;
        margin-top: 1.75rem;
      }

      a {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        min-height: 2.75rem;
        padding: 0 1rem;
        border-radius: 999px;
        text-decoration: none;
        border: 1px solid var(--border);
      }

      .primary {
        color: white;
        background: var(--fg);
      }

      .secondary {
        color: var(--fg);
        background: transparent;
      }
    </style>
  </head>
  <body>
    <main>
      <div class="card">
        <p class="eyebrow">Static Bootstrap</p>
        <h1>Minimal frontend, ready to customize.</h1>
        <p>
          This static app was generated from the template so you can ship a simple
          frontend without introducing a full dynamic stack.
        </p>
        <div class="actions">
          <a class="primary" href="./">Reload home</a>
          <a class="secondary" href="./404.html">Open 404 page</a>
        </div>
      </div>
    </main>
  </body>
</html>
EOF

cat <<'EOF' > "$TARGET_DIR/404.html"
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Page not found</title>
    <style>
      :root {
        --bg: #14110f;
        --fg: #f7f5ef;
        --muted: rgba(247, 245, 239, 0.72);
        --accent: #d8a47f;
      }

      * {
        box-sizing: border-box;
      }

      body {
        margin: 0;
        min-height: 100vh;
        display: grid;
        place-items: center;
        padding: 2rem;
        color: var(--fg);
        font-family: Georgia, "Times New Roman", serif;
        background:
          radial-gradient(circle at top, rgba(216, 164, 127, 0.18), transparent 28%),
          linear-gradient(180deg, #1e1916 0%, var(--bg) 100%);
      }

      main {
        width: min(560px, 100%);
        text-align: center;
      }

      h1 {
        margin: 0;
        font-size: clamp(3rem, 10vw, 6rem);
        line-height: 1;
      }

      p {
        margin: 1rem 0 0;
        color: var(--muted);
        line-height: 1.6;
      }

      a {
        display: inline-block;
        margin-top: 1.5rem;
        color: var(--bg);
        background: var(--accent);
        text-decoration: none;
        padding: 0.8rem 1.1rem;
        border-radius: 999px;
      }
    </style>
  </head>
  <body>
    <main>
      <h1>404</h1>
      <p>The requested page does not exist in this static app.</p>
      <a href="./">Back to home</a>
    </main>
  </body>
</html>
EOF

cat <<EOF

Static app created in $TARGET_DIR
Next steps:
  1. Run make test-static
  2. Run make dev-static
  3. Customize the HTML and deploy with npm run sst:deploy
EOF
