import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @State private var showNewBet = false

    var body: some View {
        VStack(spacing: 16) {

            ModeSelectorView()

            if appState.mode == .simulation {
                SimulationBanner()
            }

            Text("Bank actual")
            Text("€\(appState.activeBank, specifier: "%.2f")")
                .font(.largeTitle)
                .foregroundColor(.green)

            Button("➕ Nueva apuesta") {
                showNewBet = true
            }
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $showNewBet) {
                NewBetView(bank: appState.activeBank)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Dashboard")
    }
}
