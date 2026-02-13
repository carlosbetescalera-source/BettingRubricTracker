import Foundation

struct StakeEngine {

    /// Devuelve el stake recomendado según bank y score
    static func recommendedStake(bank: Double, score: Int) -> Double {

        let percentage: Double

        switch score {
        case 9...10:
            percentage = 0.05      // 5%
        case 8:
            percentage = 0.04      // 4%
        case 7:
            percentage = 0.03      // 3%
        default:
            percentage = 0.0       // no apostar
        }

        let stake = bank * percentage

        // Redondeo seguro
        return max(0, (stake * 100).rounded() / 100)
    }
}
