import SwiftUI

struct NewBetView: View {

    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss

    // MARK: - Contexto
    @State private var sport: String = "Fútbol"
    @State private var competition: String = ""
    @State private var market: String = ""
    @State private var selection: String = ""

    // MARK: - Cuota
    @State private var odds: Double = 1.80

    // MARK: - Rúbrica
    @State private var confidence: Int = 5
    @State private var disciplineScore: Int = 5
    @State private var valueScore: Int = 5

    // MARK: - Stake
    @State private var useAutoStake: Bool = true
    @State private var manualStake: Double = 0

    // MARK: - Notas
    @State private var notes: String = ""

    // MARK: - Alertas disciplina
    @State private var warnings: [DisciplineWarning] = []
    @State private var showWarnings = false

    var body: some View {
        NavigationStack {
            Form {

                // MARK: - Contexto
                Section("Contexto") {
                    TextField("Deporte", text: $sport)
                    TextField("Competición", text: $competition)
                }

                // MARK: - Mercado
                Section("Mercado") {
                    TextField("Mercado", text: $market)
                    TextField("Selección", text: $selection)

                    TextField("Cuota", value: $odds, format: .number)
                        .keyboardType(.decimalPad)
                }

                // MARK: - Rúbrica
                Section("Rúbrica (1–10)") {
                    Stepper("Confianza: \(confidence)", value: $confidence, in: 1...10)
                    Stepper("Disciplina: \(disciplineScore)", value: $disciplineScore, in: 1...10)
                    Stepper("Valor: \(valueScore)", value: $valueScore, in: 1...10)

                    Text("Score final: \(finalScore)")
                        .font(.headline)
                        .foregroundColor(finalScore >= 7 ? .green : .red)
                }

                // MARK: - Gestión
                Section("Gestión") {

                    Toggle("Stake automático", isOn: $useAutoStake)

                    if useAutoStake {
                        Text("Stake recomendado: \(recommendedStake, specifier: "%.2f") €")
                            .foregroundColor(finalScore >= 7 ? .green : .orange)
                    } else {
                        TextField("Stake manual", value: $manualStake, format: .number)
                            .keyboardType(.decimalPad)
                    }

                    Text("Bank actual: \(appState.activeBank, specifier: "%.2f") €")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                // MARK: - Notas
                Section("Notas") {
                    TextEditor(text: $notes)
                        .frame(height: 80)
                }

                // MARK: - Límite diario
                if appState.isDailyLimitReached {
                    Section {
                        Text("🚫 Límite diario de pérdidas alcanzado")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Nueva apuesta")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        handleSave()
                    }
                    .disabled(!canSave)
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
            .alert("Advertencias de disciplina", isPresented: $showWarnings) {
                Button("Cancelar", role: .cancel) {}
                Button("Apostar igualmente", role: .destructive) {
                    saveBet()
                }
            } message: {
                Text(warnings.map { "• \($0.message)" }.joined(separator: "\n"))
            }
        }
    }

    // MARK: - Score final
    var finalScore: Int {
        (confidence + disciplineScore + valueScore) / 3
    }

    // MARK: - Stake recomendado
    var recommendedStake: Double {
        StakeEngine.recommendedStake(
            bank: appState.activeBank,
            score: finalScore
        )
    }

    // MARK: - Validación
    var canSave: Bool {
        let stake = useAutoStake ? recommendedStake : manualStake

        return !competition.isEmpty &&
               !market.isEmpty &&
               !selection.isEmpty &&
               odds > 1 &&
               stake > 0 &&
               stake <= appState.activeBank &&
               finalScore >= 7 &&
               !appState.isDailyLimitReached
    }

    // MARK: - Guardado con disciplina
    func handleSave() {

        warnings = DisciplineEngine.evaluate(
            bank: appState.activeBank,
            stake: useAutoStake ? recommendedStake : manualStake,
            odds: odds,
            score: finalScore
        )

        if warnings.isEmpty {
            saveBet()
        } else {
            showWarnings = true
        }
    }

    // MARK: - Guardar apuesta
    func saveBet() {

        let stake = useAutoStake ? recommendedStake : manualStake

        let bet = Bet(
            mode: appState.mode == .real ? .real : .simulation,
            sport: sport,
            competition: competition,
            market: market,
            selection: selection,
            odds: odds,
            stake: stake,
            bankBefore: appState.activeBank,
            pickCount: 1,
            confidence: confidence,
            disciplineScore: disciplineScore,
            valueScore: valueScore,
            notes: notes.isEmpty ? nil : notes
        )

        appState.addBet(bet)
        dismiss()
    }
}
