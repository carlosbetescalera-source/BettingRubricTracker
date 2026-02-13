import SwiftUI

struct BetListView: View {

    @EnvironmentObject var appState: AppState

    var body: some View {
        List {

            if appState.bets.isEmpty {
                Text("No hay apuestas registradas")
                    .foregroundColor(.secondary)
            }

            ForEach(appState.bets) { bet in
                NavigationLink {
                    ResolveBetView(bet: bet)
                } label: {
                    VStack(alignment: .leading, spacing: 6) {

                        // MARK: - Línea principal
                        HStack {
                            Text(bet.selection)
                                .font(.headline)

                            Spacer()

                            Text("Score \(bet.finalScore)")
                                .font(.subheadline)
                                .foregroundColor(bet.finalScore >= 7 ? .green : .orange)
                        }

                        // MARK: - Mercado
                        Text("\(bet.market) · @\(bet.odds, specifier: "%.2f")")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        // MARK: - Info inferior
                        HStack {
                            Text("Stake \(bet.stake, specifier: "%.2f") €")
                                .font(.caption)

                            Spacer()

                            statusLabel(for: bet)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle("Historial de apuestas")
    }

    // MARK: - Estado visual
    private func statusLabel(for bet: Bet) -> some View {
        switch bet.result {
        case .pending:
            return Text("Pendiente")
                .font(.caption)
                .foregroundColor(.blue)
        case .win:
            return Text("Ganada")
                .font(.caption)
                .foregroundColor(.green)
        case .loss:
            return Text("Perdida")
                .font(.caption)
                .foregroundColor(.red)
        case .void:
            return Text("Nula")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}
