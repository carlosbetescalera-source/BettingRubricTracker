import Foundation

final class RulesEngine: ObservableObject {
    @Published var dailyBets: Int = 0
    @Published var dailyExposure: Double = 0
    @Published var consecutiveLosses: Int = 0
    @Published var blockedUntil: Date? = nil

    let maxDailyBets = 2
    let maxDailyExposure: Double = 60
    let maxConsecutiveLosses = 2

    func canPlaceBet(stake: Double) -> Bool {
        if let blockedUntil, blockedUntil > Date() { return false }
        if dailyBets >= maxDailyBets { return false }
        if dailyExposure + stake > maxDailyExposure { return false }
        return true
    }

    func registerResult(win: Bool) {
        if win {
            consecutiveLosses = 0
        } else {
            consecutiveLosses += 1
            if consecutiveLosses >= maxConsecutiveLosses {
                blockedUntil = Calendar.current.date(byAdding: .day, value: 1, to: Date())
            }
        }
    }
}
