import SwiftUI

struct NewBetView: View {
    let bank: Double
    @EnvironmentObject var rulesEngine: RulesEngine
    @State private var bet = Bet()
    @State private var showRubric = false

    var maxStake: Double { bank * 0.1 }

    var body: some View {
        NavigationStack {
            Form {
                Section("Datos básicos") {
                    TextField("Competición", text: $bet.competition)
                    TextField("Partido", text: $bet.match)

                    Picker("Mercado", selection: $bet.market) {
                        Text("+0.5 equipo").tag("+0.5 equipo")
                        Text("+1.5 goles").tag("+1.5 goles")
                    }

                    TextField("Cuota", value: $bet.odds, format: .number)
                        .keyboardType(.decimalPad)

                    TextField("Stake (€)", value: $bet.stake, format: .number)
                        .keyboardType(.decimalPad)
                        .foregroundColor(bet.stake > maxStake ? .red : .primary)
                }

                Button("Continuar a rúbrica") {
                    showRubric = true
                }
                .disabled(
                    bet.stake <= 0 ||
                    bet.stake > maxStake ||
                    !rulesEngine.canPlaceBet(stake: bet.stake)
                )
            }
            .navigationTitle("Nueva apuesta")
            .navigationDestination(isPresented: $showRubric) {
                RubricView(bet: bet)
            }
        }
    }
}
