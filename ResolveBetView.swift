import SwiftUI

struct ResolveBetView: View {

    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss

    let bet: Bet

    @State private var postNote: String = ""

    var body: some View {
        VStack(spacing: 20) {

            // MARK: - Resumen apuesta
            VStack(spacing: 6) {
                Text(bet.selection)
                    .font(.title2)
                    .bold()

                Text("\(bet.market) · @\(bet.odds, specifier: "%.2f")")
                    .foregroundColor(.secondary)

                Text("Stake \(bet.stake, specifier: "%.2f") €")
                    .font(.headline)
            }

            Divider()

            // MARK: - Nota post-apuesta
            VStack(alignment: .leading) {
                Text("Nota post-apuesta")
                    .font(.caption)
                    .foregroundColor(.secondary)

                TextEditor(text: $postNote)
                    .frame(height: 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray.opacity(0.3))
                    )
            }

            Divider()

            // MARK: - Botones de resolución
            VStack(spacing: 12) {

                Button("✅ GANADA") {
                    resolve(.win)
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)

                Button("❌ PERDIDA") {
                    resolve(.loss)
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)

                Button("➖ NULA") {
                    resolve(.void)
                }
                .buttonStyle(.bordered)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Resolver apuesta")
    }

    // MARK: - Resolver
    private func resolve(_ result: BetResult) {

        appState.resolveBet(
            betId: bet.id,
            result: result
        )

        dismiss()
    }
}
