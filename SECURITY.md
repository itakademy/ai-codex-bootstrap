# Security Policy

## Supported Versions

This repository is a template. Security fixes should be applied to the latest active version of the template and then propagated to downstream projects as needed.

| Version | Supported |
| ------- | --------- |
| 0.1.x   | Yes       |

## Reporting a Vulnerability

If you discover a security issue in this template or one of its generated workflows:

1. Do not open a public issue with exploit details.
2. Report the problem privately to the maintainers through the agreed private channel.
3. Include:
   - affected file or workflow
   - reproduction steps
   - impact
   - suggested mitigation if available

You should receive an acknowledgement as soon as reasonably possible.

## Scope

This policy applies to:

- the repository template itself
- local automation scripts
- generated project scaffolding
- deployment guidance documented in the repository

It does not automatically cover:

- downstream projects that diverged from the template
- third-party services outside the repository's control
- local machine configuration issues unrelated to the template

## Security Expectations

When contributing to this repository:

- avoid committing secrets
- validate environment variables before deployment
- prefer the smallest necessary infrastructure footprint
- document durable security-impacting decisions in ADRs
- treat deployment defaults as security-relevant decisions

## Sensitive Data

Never commit:

- API keys
- cloud credentials
- production secrets
- private certificates
- `.env` files containing real secrets

Use:

- `.env.example` for documented placeholders
- `.env.schema` for validation
- secret managers or platform-native secure storage for real credentials

## Dependency Hygiene

- review dependency additions carefully
- keep tooling and frameworks up to date
- prefer official and well-maintained packages
- document new security-sensitive dependencies when they affect architecture or operations
