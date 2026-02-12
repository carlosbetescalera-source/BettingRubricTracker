import SwiftUI

struct RubricView: View {
    @Environment(\.dismiss) var dismiss

    @State private var totalScore: Int = 0
    @State private var decision: RubricDecision? = nil

    var body: some View {
        VStack(spacing: 20) {

            Text("Evaluación de la apuesta")
                .font(.title2)
                .bold()

            Stepper("Puntuación total: \(totalScore)", value: $totalScore, in: 0...10)

            Button("Calcular decisión") {
                decision = RubricEngine.decision(score: totalScore)
            }
            .buttonStyle(.borderedProminent)

            if let decision {
                Text(decision == .bet ? "✅ APUESTA VÁLIDA" : "❌ NO APOSTAR")
                    .font(.title)
                    .foregroundColor(decision == .bet ? .green : .red)
            }

            Button("Cerrar") {
                dismiss()
            }
            .padding(.top)
        }
        .padding()
    }
}
