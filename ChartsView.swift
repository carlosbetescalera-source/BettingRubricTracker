import SwiftUI

struct ChartsView: View {

    @EnvironmentObject var appState: AppState

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                // MARK: - Evolución del bank
                Text("Evolución del bank")
                    .font(.headline)

                LineChartView(values: bankValues)
                    .frame(height: 220)

                Divider()

                // MARK: - Resumen numérico
                Text("Resumen")
                    .font(.headline)

                HStack {
                    statBox(
                        title: "Bank actual",
                        value: "\(appState.activeBank, specifier: "%.2f") €"
                    )

                    statBox(
                        title: "ROI",
                        value: "\(appState.roi, specifier: "%.2f") %"
                    )
                }

                HStack {
                    statBox(
                        title: "Acierto",
                        value: "\(appState.winRate, specifier: "%.1f") %"
                    )

                    statBox(
                        title: "Score medio",
                        value: "\(appState.averageScore, specifier: "%.1f")"
                    )
                }
            }
            .padding()
        }
        .navigationTitle("Gráficos")
    }

    // MARK: - Datos del gráfico
    private var bankValues: [Double] {
        let resolved = appState.resolvedBets
        guard !resolved.isEmpty else { return [] }

        var values: [Double] = []
        for bet in resolved {
            if let after = bet.bankAfter {
                values.append(after)
            }
        }
        return values
    }

    // MARK: - Caja estadística
    private func statBox(title: String, value: String) -> some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)

            Text(value)
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}
