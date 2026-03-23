export default function OperatorPage() {
  return (
    <div className="space-y-4">
      <h1 className="text-2xl font-semibold tracking-tight">Operator overview</h1>
      <p className="max-w-2xl text-sm leading-relaxed text-zinc-400">
        Active branches, priority scores, blockers, and next actions will render
        here once the API and workers are connected (V1 Phase 1).
      </p>
      <div className="grid gap-4 md:grid-cols-2">
        <section className="rounded-lg border border-zinc-800 bg-zinc-900/40 p-4">
          <h2 className="text-sm font-medium text-zinc-200">Next actions</h2>
          <p className="mt-2 text-xs text-zinc-500">No items yet.</p>
        </section>
        <section className="rounded-lg border border-zinc-800 bg-zinc-900/40 p-4">
          <h2 className="text-sm font-medium text-zinc-200">Blockers</h2>
          <p className="mt-2 text-xs text-zinc-500">No blockers.</p>
        </section>
      </div>
    </div>
  );
}
