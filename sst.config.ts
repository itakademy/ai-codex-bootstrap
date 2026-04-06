/// <reference path="./.sst/platform/config.d.ts" />

export default $config({
  app(input) {
    const cloudflareAccountId = process.env.CLOUDFLARE_ACCOUNT_ID?.trim();
    const awsProfile = process.env.AWS_PROFILE?.trim();

    return {
      name: process.env.APP_NAME?.trim() || "orz-ai",
      home: "aws",
      removal: input.stage === "production" ? "retain" : "remove",
      providers: {
        aws: {
          region: process.env.AWS_REGION?.trim() || "eu-west-3",
          ...(awsProfile ? { profile: awsProfile } : {})
        },
        ...(cloudflareAccountId
          ? {
              cloudflare: {
                accountId: cloudflareAccountId
              }
            }
          : {})
      }
    };
  },
  async run() {
    const { deployTemplate } = await import("./infra/app");
    return deployTemplate();
  }
});
