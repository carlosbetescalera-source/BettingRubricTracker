import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @State private var showNewBet = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {

                ModeSelectorView()

                if appState.mode == .simulation {
                    SimulationBanner()
                }

                Text("Bank actual")
                Text("€\(appState.activeBank, specifier: "%.2f")")
                    .font(.largeTitle)
                    .foregroundColor(.green)

                Button("+ Nueva apuesta") {
                    showNewBet = true
                }
                .buttonStyle(.borderedProminent)
                .sheet(isPresented: $showNewBet) {
                    NewBetView(bank: appState.activeBank)
                }

                // 🔽 BOTÓN NUEVO: ACCESO A LA RÚBRICA
                NavigationLink(destination: RubricView()) {
                    Text("Evaluar apuesta (Rúbrica)")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Dashboard")
        }
    }
}
