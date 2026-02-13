import SwiftUI

struct HomeView: View {

    @EnvironmentObject var appState: AppState

    @State private var showRealModeAlert = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                // MARK: - Bank
                VStack {
                    Text("Bank actual")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("\(appState.activeBank, specifier: "%.2f") €")
                        .font(.largeTitle)
                        .bold()
                }

                // MARK: - Modo
                Toggle(
                    "Modo REAL",
                    isOn: Binding(
                        get: { appState.mode == .real },
                        set: { newValue in
                            if newValue {
                                showRealModeAlert = true
                            } else {
                                appState.mode = .simulation
                            }
                        }
                    )
                )
                .padding(.horizontal)
                .alert("Entrar en modo REAL", isPresented: $showRealModeAlert) {
                    Button("Cancelar", role: .cancel) {}
                    Button("Confirmar", role: .destructive) {
                        appState.mode = .real
                    }
                } message: {
                    Text("Las apuestas afectarán a dinero real.")
                }

                Divider()

                // MARK: - Navegación principal
                VStack(spacing: 12) {

                    NavigationLink("➕ Nueva apuesta") {
                        NewBetView()
                    }
                    .buttonStyle(.borderedProminent)

                    NavigationLink("📋 Historial de apuestas") {
                        BetListView()
                    }
                    .buttonStyle(.bordered)

                    NavigationLink("📊 Estadísticas") {
                        StatsView()
                    }
                    .buttonStyle(.bordered)

                    NavigationLink("📈 Gráficos") {
                        ChartsView()
                    }
                    .buttonStyle(.bordered)

                    NavigationLink("🤖 Insights IA") {
                        AIInsightsView()
                    }
                    .buttonStyle(.bordered)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Betting Tracker")
        }
    }
}
