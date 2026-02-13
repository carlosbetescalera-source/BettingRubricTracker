import Foundation
import SwiftUI

enum AppMode {
    case real
    case simulation
}

final class AppState: ObservableObject {

    // MARK: - Modo
    @Published var mode: AppMode = .simulation

    // MARK: - Bank
    @Published var realBank: Double = 1000
    @Published var simulationBank: Double = 1000

    var activeBank: Double {
        mode == .real ? realBank : simulationBank
    }

    // MARK: - Apuestas
    @Published var bets: [Bet] = []

    // MARK: - Añadir apuesta
    func addBet(_ bet: Bet) {
        bets.insert(bet, at: 0)
    }

    // MARK: - Resolver apuesta
    func resolveBet(_ bet: Bet, win: Bool) {
        let profit = win ? bet.stake * (bet.odds - 1) : -bet.stake

        if mode == .real {
            realBank += profit
        } else {
            simulationBank += profit
        }
    }
}
