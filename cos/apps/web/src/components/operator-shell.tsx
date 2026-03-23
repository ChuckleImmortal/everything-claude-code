"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";

const RAIL = [
  { href: "/inbox", label: "Inbox" },
  { href: "/graph", label: "Graph" },
  { href: "/projects", label: "Projects" },
  { href: "/research", label: "Research" },
  { href: "/media", label: "Media" },
  { href: "/studies", label: "Studies" },
  { href: "/settings", label: "Settings" },
] as const;

function NavLink({ href, label }: { href: string; label: string }) {
  const pathname = usePathname();
  const active = pathname === href || (href !== "/operator" && pathname.startsWith(href));
  return (
    <Link
      href={href}
      className={`block rounded-md px-3 py-2 text-sm transition-colors ${
        active
          ? "bg-zinc-800 text-zinc-50"
          : "text-zinc-400 hover:bg-zinc-900 hover:text-zinc-100"
      }`}
    >
      {label}
    </Link>
  );
}

export function OperatorShell({ children }: { children: React.ReactNode }) {
  return (
    <div className="flex h-screen min-h-0 flex-col bg-zinc-950 text-zinc-100">
      <header className="flex h-12 shrink-0 items-center gap-3 border-b border-zinc-800 px-4">
        <Link
          href="/operator"
          className="text-sm font-semibold tracking-tight text-zinc-100"
        >
          COS
        </Link>
        <div className="mx-2 h-5 w-px bg-zinc-800" aria-hidden />
        <input
          type="search"
          placeholder="Global search…"
          className="hidden max-w-md flex-1 rounded-md border border-zinc-800 bg-zinc-900 px-3 py-1.5 text-sm text-zinc-100 placeholder:text-zinc-500 md:block"
          disabled
          aria-label="Global search (coming soon)"
        />
        <div className="ml-auto flex items-center gap-2">
          <button
            type="button"
            className="rounded-md border border-zinc-700 px-3 py-1.5 text-xs font-medium text-zinc-200 hover:bg-zinc-900"
            disabled
          >
            Quick capture
          </button>
          <button
            type="button"
            className="rounded-md border border-zinc-700 px-3 py-1.5 text-xs font-medium text-zinc-200 hover:bg-zinc-900"
            disabled
          >
            New project
          </button>
          <button
            type="button"
            className="rounded-md bg-emerald-700 px-3 py-1.5 text-xs font-medium text-white hover:bg-emerald-600"
            disabled
          >
            Run
          </button>
        </div>
      </header>

      <div className="flex min-h-0 flex-1">
        <aside className="flex w-52 shrink-0 flex-col border-r border-zinc-800 bg-zinc-950 py-3">
          <div className="px-3 pb-2 text-xs font-medium uppercase tracking-wide text-zinc-500">
            Navigate
          </div>
          <nav className="flex flex-col gap-0.5 px-2">
            <NavLink href="/operator" label="Operator" />
            {RAIL.map((item) => (
              <NavLink key={item.href} href={item.href} label={item.label} />
            ))}
          </nav>
        </aside>

        <main className="min-w-0 flex-1 overflow-auto border-r border-zinc-800 bg-zinc-950 p-6">
          {children}
        </main>

        <aside className="hidden w-72 shrink-0 flex-col bg-zinc-950 p-4 text-sm text-zinc-400 lg:flex">
          <div className="text-xs font-semibold uppercase tracking-wide text-zinc-500">
            Inspector
          </div>
          <p className="mt-3 leading-relaxed">
            Provenance, confidence, sources, related nodes, and run history will
            appear here. This panel answers why the system believes something.
          </p>
        </aside>
      </div>

      <footer className="h-28 shrink-0 border-t border-zinc-800 bg-zinc-950 px-4 py-2">
        <div className="text-xs font-semibold uppercase tracking-wide text-zinc-500">
          Console
        </div>
        <div className="mt-2 font-mono text-xs text-zinc-500">
          Traces · tool calls · approvals · failures (wired in Phase 1)
        </div>
      </footer>
    </div>
  );
}
