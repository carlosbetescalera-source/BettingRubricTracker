import SwiftUI

struct StatsView: View {

    @EnvironmentObject var appState: AppState

    var body: some View {
        Form {

            // MARK: - Resumen general
            Section("Resumen") {
                statRow(
                    title: "Apuestas resueltas",
                    value: "\(appState.resolvedBets.count)"
                )

                statRow(
                    title: "Stake total",
                    value: "\(appState.totalStaked, specifier: "%.2f") €"
                )

                statRow(
                    title: "Beneficio total",
                    value: "\(appState.totalProfit, specifier: "%.2f") €"
                )
            }

            // MARK: - Rendimiento
            Section("Rendimiento") {
                statRow(
                    title: "ROI",
                    value: "\(appState.roi, specifier: "%.2f") %"
                )

                statRow(
                    title: "Acierto",
                    value: "\(appState.winRate, specifier: "%.1f") %"
                )

                statRow(
                    title: "Score medio",
                    value: "\(appState.averageScore, specifier: "%.1f")"
                )
            }

            // MARK: - Modo activo
            Section("Modo actual") {
                Text(appState.mode == .real ? "Modo REAL" : "Modo SIMULACIÓN")
                    .foregroundColor(appState.mode == .real ? .red : .blue)
            }
        }
        .navigationTitle("Estadísticas")
    }

    // MARK: - Fila reutilizable
    private func statRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .bold()
        }
    }
}
