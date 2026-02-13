import Foundation

// MARK: - Insight IA
struct AIInsight: Identifiable {
    let id = UUID()
    let message: String
    let severity: Severity

    enum Severity {
        case good
        case warning
    }
}

// MARK: - Evaluador IA (local)
struct AIEvaluator {

    static func analyze(bets: [Bet]) -> [AIInsight] {

        let resolved = bets.filter { $0.result != .pending }
        guard resolved.count >= 10 else {
            return [
                AIInsight(
                    message: "Aún no hay suficientes datos para análisis IA (mín. 10 apuestas resueltas).",
                    severity: .warning
                )
            ]
        }

        var insights: [AIInsight] = []

        // 1) Rendimiento por score
        let lowScore = resolved.filter { $0.finalScore <= 7 }
        let highScore = resolved.filter { $0.finalScore >= 8 }

        let lowScoreROI = roi(for: lowScore)
        let highScoreROI = roi(for: highScore)

        if lowScoreROI < 0 {
            insights.append(
                AIInsight(
                    message: "Las apuestas con score ≤ 7 tienen ROI negativo (\(Int(lowScoreROI))%).",
                    severity: .warning
                )
            )
        }

        if highScoreROI > 0 {
            insights.append(
                AIInsight(
                    message: "Las apuestas con score ≥ 8 son rentables (\(Int(highScoreROI))%).",
                    severity: .good
                )
            )
        }

        // 2) Cuotas bajas
        let lowOdds = resolved.filter { $0.odds < 1.50 }
        let lowOddsROI = roi(for: lowOdds)

        if lowOddsROI < 0 {
            insights.append(
                AIInsight(
                    message: "Las cuotas < 1.50 muestran ROI negativo (\(Int(lowOddsROI))%).",
                    severity: .warning
                )
            )
        }

        // 3) Stake elevado
        let highStake = resolved.filter { bet in
            guard let before = bet.bankBefore else { return false }
            return bet.stake > before * 0.05
        }
        let highStakeROI = roi(for: highStake)

        if highStakeROI < 0 {
            insights.append(
                AIInsight(
                    message: "Stakes > 5% del bank reducen el rendimiento (\(Int(highStakeROI))%).",
                    severity: .warning
                )
            )
        }

        if insights.isEmpty {
            insights.append(
                AIInsight(
                    message: "Buen control general. Mantén la disciplina actual.",
                    severity: .good
                )
            )
        }

        return insights
    }

    // MARK: - ROI helper
    private static func roi(for bets: [Bet]) -> Double {
        let staked = bets.reduce(0) { $0 + $1.stake }
        guard staked > 0 else { return 0 }

        let profit = bets.reduce(0) { acc, bet in
            switch bet.result {
            case .win:
                return acc + bet.stake * (bet.odds - 1)
            case .loss:
                return acc - bet.stake
            default:
                return acc
            }
        }

        return (profit / staked) * 100
    }
}
