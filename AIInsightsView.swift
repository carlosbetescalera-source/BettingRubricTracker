import SwiftUI

struct AIInsightsView: View {

    @EnvironmentObject var appState: AppState

    var body: some View {
        let insights = AIEvaluator.analyze(bets: appState.bets)

        List {
            ForEach(insights) { insight in
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: insight.severity == .good ? "checkmark.circle.fill" : "exclamationmark.triangle.fill")
                        .foregroundColor(insight.severity == .good ? .green : .orange)

                    Text(insight.message)
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle("IA · Insights")
    }
}
