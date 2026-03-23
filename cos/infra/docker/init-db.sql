-- Layer A: canonical transactional objects (V1 baseline)

CREATE TABLE IF NOT EXISTS sources (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    type TEXT NOT NULL,
    title TEXT,
    raw_text TEXT,
    source_uri TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    imported_at TIMESTAMPTZ DEFAULT now(),
    author TEXT,
    reliability_score DOUBLE PRECISION
);

CREATE TABLE IF NOT EXISTS source_chunks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    source_id UUID NOT NULL REFERENCES sources (id) ON DELETE CASCADE,
    chunk_index INT NOT NULL,
    text TEXT NOT NULL,
    embedding_ref TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS claims (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    source_id UUID NOT NULL REFERENCES sources (id) ON DELETE CASCADE,
    text TEXT NOT NULL,
    claim_type TEXT,
    confidence DOUBLE PRECISION,
    status TEXT NOT NULL CHECK (status IN ('observed', 'inferred', 'validated', 'contradicted'))
);

CREATE TABLE IF NOT EXISTS concepts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    description TEXT,
    domain TEXT,
    confidence DOUBLE PRECISION
);

CREATE TABLE IF NOT EXISTS projects (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    objective TEXT,
    status TEXT NOT NULL DEFAULT 'active',
    strategic_fit INT CHECK (strategic_fit BETWEEN 1 AND 5),
    expected_value INT CHECK (expected_value BETWEEN 1 AND 5),
    success_probability DOUBLE PRECISION CHECK (success_probability BETWEEN 0.05 AND 0.95),
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS project_branches (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID NOT NULL REFERENCES projects (id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    meta JSONB DEFAULT '{}'::jsonb
);

CREATE TABLE IF NOT EXISTS tasks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID NOT NULL REFERENCES projects (id) ON DELETE CASCADE,
    parent_task_id UUID REFERENCES tasks (id) ON DELETE SET NULL,
    title TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'open',
    owner TEXT,
    due_at TIMESTAMPTZ,
    effort_score INT,
    dependency_risk INT
);

CREATE TABLE IF NOT EXISTS artifacts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID REFERENCES projects (id) ON DELETE SET NULL,
    kind TEXT NOT NULL,
    uri TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS runs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    workflow_name TEXT NOT NULL,
    input_ref TEXT,
    model TEXT,
    toolset TEXT,
    latency_ms INT,
    cost_estimate DOUBLE PRECISION,
    output_ref TEXT,
    human_score DOUBLE PRECISION,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS evaluations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    run_id UUID NOT NULL REFERENCES runs (id) ON DELETE CASCADE,
    metric_name TEXT NOT NULL,
    metric_value DOUBLE PRECISION NOT NULL,
    grader_type TEXT,
    notes TEXT
);

CREATE TABLE IF NOT EXISTS agents (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    config JSONB DEFAULT '{}'::jsonb
);

CREATE TABLE IF NOT EXISTS model_policies (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL UNIQUE,
    reasoning_model TEXT NOT NULL,
    standard_model TEXT NOT NULL,
    fast_model TEXT NOT NULL,
    transcribe_model TEXT,
    transcribe_diarize_model TEXT
);

CREATE TABLE IF NOT EXISTS attachments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    source_id UUID REFERENCES sources (id) ON DELETE CASCADE,
    storage_key TEXT NOT NULL,
    mime_type TEXT,
    byte_size BIGINT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_source_chunks_source ON source_chunks (source_id);
CREATE INDEX IF NOT EXISTS idx_claims_source ON claims (source_id);
CREATE INDEX IF NOT EXISTS idx_tasks_project ON tasks (project_id);
CREATE INDEX IF NOT EXISTS idx_evaluations_run ON evaluations (run_id);
