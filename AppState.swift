import Foundation
import SwiftUI

enum AppMode {
    case real
    case simulation
}

final class AppState: ObservableObject {

    @Published var mode: AppMode = .simulation

    @Published var realBank: Double = 1000
    @Published var simulationBank: Double = 1000

    var activeBank: Double {
        mode == .real ? realBank : simulationBank
    }

    func applyResult(win: Bool, stake: Double, odds: Double) {
        let profit = win ? stake * (odds - 1) : -stake

        if mode == .real {
            realBank += profit
        } else {
            simulationBank += profit
        }
    }
}
