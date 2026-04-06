# ADR-001 - Laravel API deploy target defaults to Lambda Bref

## Status

`accepted`

## Context

This repository is an AI-first delivery template designed to stay lean and cost-effective by default.

When a backend is needed, the default framework is Laravel. The template also targets AWS for deployment and Cloudflare for DNS.

The open question was which AWS service should be the default deployment target for a Laravel API:

- `AWS Lambda + API Gateway` using `Bref`
- `ECS Fargate + Application Load Balancer`
- `AWS App Runner`

The template optimizes for the lowest acceptable operational cost and the smallest possible idle footprint. Most initial API workloads for this kind of repository are expected to be:

- low to moderate traffic
- stateless HTTP APIs
- webhook endpoints
- cron and event-driven tasks
- products that may not yet have stable or constant traffic patterns

## Decision

The default deployment target for Laravel APIs in this repository is `AWS Lambda + API Gateway` using `Bref`.

`ECS Fargate + ALB` is the fallback option when technical constraints make the serverless target unsuitable.

`AWS App Runner` is not the default target in this template.

## Alternatives considered

- `AWS Lambda + API Gateway` with `Bref`
  - Best fit for low idle cost and variable traffic
  - Good fit for stateless APIs and event-driven workloads
  - Aligns with the template principle of not paying for always-on compute unless justified

- `ECS Fargate + ALB`
  - Good fit for container-native workloads and long-running processes
  - More flexible for binaries, extensions, and runtime behaviors that are awkward on Lambda
  - Higher baseline running cost because compute and load balancer resources stay provisioned

- `AWS App Runner`
  - Simpler operational model than ECS in some scenarios
  - Still keeps compute resources provisioned while the service is running
  - Less aligned with the template goal of minimizing idle compute cost

## Consequences

### Positive

- The template has a clear default for Laravel deployment decisions.
- Backend cost stays low while traffic is low or irregular.
- The default stack remains aligned with the repository principle of starting as small as possible.
- The decision works well for APIs, webhooks, and event-driven backend use cases.
- The fallback path remains available when the project outgrows the serverless model.

### Negative

- Some Laravel workloads may require adaptation for Lambda execution constraints.
- Certain PHP extensions, binaries, or long-running behaviors may be easier to support in containers.
- Teams unfamiliar with `Bref` or Lambda operational patterns may need a short ramp-up period.
- A later migration to `ECS Fargate` may be required if traffic or runtime constraints change materially.

## Notes

- Related specs: future backend specs in `specs/`
- Related recipes: `recipes/laravel-api-lambda-bref.md`
- Related implementation: `docs/architecture.md`, `README.md`, `.env.example`, `infra/app.ts`
