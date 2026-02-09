import SwiftUI

enum AppMode: String, CaseIterable {
    case real = "Real"
    case simulation = "Simulación"
}

final class AppState: ObservableObject {
    @Published var mode: AppMode = .real
    @Published var realBank: Double = 200
    @Published var simulationBank: Double = 200

    var activeBank: Double {
        mode == .real ? realBank : simulationBank
    }

    func updateBank(amount: Double) {
        if mode == .real {
            realBank += amount
        } else {
            simulationBank += amount
        }
    }
}
