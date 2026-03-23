import { OperatorShell } from "@/components/operator-shell";

export default function DashboardLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return <OperatorShell>{children}</OperatorShell>;
}
