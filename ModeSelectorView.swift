import SwiftUI

struct ModeSelectorView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        Picker("Modo", selection: $appState.mode) {
            ForEach(AppMode.allCases, id: \.self) { mode in
                Text(mode.rawValue).tag(mode)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
}

struct SimulationBanner: View {
    var body: some View {
        Text("🧪 MODO SIMULACIÓN · Sin dinero real")
            .font(.caption)
            .padding(6)
            .frame(maxWidth: .infinity)
            .background(Color.orange.opacity(0.2))
            .foregroundColor(.orange)
    }
}
