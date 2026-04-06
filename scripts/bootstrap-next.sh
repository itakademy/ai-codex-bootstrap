#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./lib/common.sh
source "${SCRIPT_DIR}/lib/common.sh"

TARGET_DIR="${1:-apps/web}"

require_missing_path "$TARGET_DIR"
require_command npx
require_command python3

info "Bootstrapping Next.js into $TARGET_DIR"

npx create-next-app@latest "$TARGET_DIR" \
  --ts \
  --eslint \
  --app \
  --src-dir \
  --use-npm \
  --import-alias "@/*" \
  --no-tailwind \
  --yes

pushd "$TARGET_DIR" >/dev/null
npm install -D vitest jsdom @testing-library/react @testing-library/jest-dom @testing-library/dom

python3 - <<'PY'
import json
from pathlib import Path

path = Path("package.json")
data = json.loads(path.read_text(encoding="utf-8"))
scripts = data.setdefault("scripts", {})
scripts["test"] = "vitest run"
scripts["test:watch"] = "vitest"
path.write_text(json.dumps(data, indent=2) + "\n", encoding="utf-8")
PY

mkdir -p src/test

cat <<'EOF' > vitest.config.ts
import { defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    environment: "jsdom",
    setupFiles: ["./src/test/setup.ts"]
  }
});
EOF

cat <<'EOF' > src/test/setup.ts
import "@testing-library/jest-dom/vitest";
EOF

cat <<'EOF' > src/test/home.test.tsx
import { readFileSync } from "node:fs";
import { join } from "node:path";
import { describe, expect, it } from "vitest";

describe("home page", () => {
  it("keeps the default page title placeholder", () => {
    const pagePath = join(process.cwd(), "src", "app", "page.tsx");
    const content = readFileSync(pagePath, "utf-8");
    expect(content).toContain("Get started by editing");
  });
});
EOF
popd >/dev/null

cat <<EOF

Next.js app created in $TARGET_DIR
Next steps:
  1. Set WEB_MODE=nextjs in .env
  2. Run make test-web
  3. Deploy with npm run sst:deploy
EOF
