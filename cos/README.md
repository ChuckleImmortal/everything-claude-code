# Cognitive Operating System (COS) — V1 scaffold

Monorepo for the **truth-grounded, graph-based operator dashboard** (Phase 0 foundation + empty V1 shell).

## Layout

| Path | Role |
|------|------|
| `apps/web` | Next.js operator UI (App Router, Tailwind) |
| `apps/api` | FastAPI backend |
| `workers/ingest` | Ingest pipeline (stub) |
| `workers/planner` | Planning worker (stub) |
| `services/graph` | Neo4j graph layer (stub) |
| `services/eval` | Eval flywheel (stub) |
| `packages/schemas` | Shared JSON Schemas |
| `infra/docker` | Postgres, Neo4j, MinIO, n8n |

## Prerequisites

- Node 18+
- Python 3.11+
- Docker (for local data stores)

## Environment

Copy `.env.example` to `apps/api/.env` and `apps/web/.env.local` as needed. Model names are **configurable**; use cost-appropriate models per task in production.

## Local infra

```bash
cd infra/docker
docker compose up -d
```

Creates Postgres (with Layer A tables), Neo4j, MinIO, and n8n.

## Web

```bash
npm install
npm run web:dev
```

Open [http://localhost:3000](http://localhost:3000) → redirects to `/operator`.

## API

```bash
cd apps/api
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload --port 8000
```

## GitHub Project

Create a project **COS Operator** with the custom fields from your plan (`Type`, `Layer`, `Priority Score`, etc.); automation hooks connect in later phases.
