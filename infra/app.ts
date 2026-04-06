import { existsSync } from "node:fs";

type WebMode = "static" | "nextjs" | "none";

function isEnabled(value: string | undefined, defaultValue: boolean): boolean {
  if (value === undefined || value === "") {
    return defaultValue;
  }

  return ["1", "true", "yes", "on"].includes(value.toLowerCase());
}

function resolveWebMode(value: string | undefined): WebMode {
  if (!value) {
    return "static";
  }

  if (value === "static" || value === "nextjs" || value === "none") {
    return value;
  }

  return "static";
}

function resolveHostname(): string | undefined {
  const domain = process.env.APP_DOMAIN?.trim();
  const subdomain = process.env.APP_SUBDOMAIN?.trim();

  if (!domain) {
    return undefined;
  }

  if (!subdomain) {
    return domain;
  }

  return `${subdomain}.${domain}`;
}

function resolveDomainConfig() {
  const hostname = resolveHostname();

  if (!hostname) {
    return undefined;
  }

  const zone = process.env.CLOUDFLARE_ZONE_ID?.trim();
  const accountId = process.env.CLOUDFLARE_ACCOUNT_ID?.trim();

  if (!zone || !accountId) {
    return { name: hostname };
  }

  return {
    name: hostname,
    dns: sst.cloudflare.dns({
      zone,
      proxy: true
    })
  };
}

export async function deployTemplate() {
  const apiDeployTarget = process.env.API_DEPLOY_TARGET?.trim() || "lambda-bref";
  const outputs: Record<string, unknown> = {
    webMode: resolveWebMode(process.env.WEB_MODE),
    apiMode: process.env.API_MODE?.trim() || "laravel",
    apiDeployTarget
  };

  const enableWeb = isEnabled(process.env.ENABLE_WEB, true);
  const webMode = resolveWebMode(process.env.WEB_MODE);
  const domain = resolveDomainConfig();

  if (enableWeb && webMode === "static") {
    const sitePath = "apps/web-static";

    if (!existsSync(sitePath)) {
      throw new Error(`Missing static site directory: ${sitePath}`);
    }

    const site = new sst.aws.StaticSite("WebStatic", {
      path: sitePath,
      errorPage: "404.html",
      ...(domain ? { domain } : {})
    });

    outputs.webUrl = site.url;
  }

  if (enableWeb && webMode === "nextjs") {
    const appPath = "apps/web";

    if (!existsSync(appPath)) {
      throw new Error(
        "WEB_MODE=nextjs requires apps/web. Run ./scripts/bootstrap-next.sh first."
      );
    }

    const site = new sst.aws.Nextjs("WebNext", {
      path: appPath,
      ...(domain ? { domain } : {})
    });

    outputs.webUrl = site.url;
  }

  outputs.apiDeployment = isEnabled(process.env.ENABLE_API, false)
    ? `Laravel requested. Default deploy target: ${apiDeployTarget}. Recommended: lambda-bref first, ecs-fargate only as fallback.`
    : "API disabled by default to avoid fixed infrastructure cost.";

  return outputs;
}
