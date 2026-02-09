import SwiftUI

struct RubricView: View {
    @State var bet: Bet
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 16) {

            RubricRow(title: "Contexto competitivo", score: $bet.context)
            RubricRow(title: "Perfil ofensivo", score: $bet.offense)
            RubricRow(title: "Rival y guion", score: $bet.rival)
            RubricRow(title: "Mercado elegido", score: $bet.marketFit)
            RubricRow(title: "Disciplina", score: $bet.discipline)

            Text("Total: \(bet.totalScore) / 10")
                .font(.title2)
                .foregroundColor(bet.totalScore >= 7 ? .green : .red)

            Button("Confirmar apuesta") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .disabled(bet.totalScore < 7)

            Spacer()
        }
        .padding()
        .navigationTitle("Rúbrica")
    }
}

struct RubricRow: View {
    let title: String
    @Binding var score: Int

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            Picker("", selection: $score) {
                Text("0").tag(0)
                Text("1").tag(1)
                Text("2").tag(2)
            }
            .pickerStyle(.segmented)
        }
    }
}
