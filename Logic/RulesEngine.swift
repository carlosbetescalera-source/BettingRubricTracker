import Foundation

struct RuleViolation: Identifiable {
    let id = UUID()
    let message: String
}

final class RulesEngine: ObservableObject {

    // CONFIGURACIÓN BASE (tu plan)
    let minOdds: Double = 1.20
    let maxOdds: Double = 2.20

    let maxStakePercent: Double = 0.10   // 10% del bank
    let maxPicks: Int = 2

    let minConfidence: Int = 6
    let minDiscipline: Int = 6
    let minValue: Int = 6
    let minFinalScore: Int = 6

    // VALIDACIÓN PRINCIPAL
    func validateBet(
        odds: Double,
        stake: Double,
        bank: Double,
        picksCount: Int,
        confidence: Int,
        discipline: Int,
        value: Int
    ) -> [RuleViolation] {

        var violations: [RuleViolation] = []

        // Odds
        if odds < minOdds || odds > maxOdds {
            violations.append(
                RuleViolation(message: "Cuota fuera de rango permitido")
            )
        }

        // Stake
        if stake > bank * maxStakePercent {
            violations.append(
                RuleViolation(message: "Stake demasiado alto para el bank actual")
            )
        }

        // Picks
        if picksCount > maxPicks {
            violations.append(
                RuleViolation(message: "Demasiados picks en la apuesta")
            )
        }

        // Rúbrica
        if confidence < minConfidence {
            violations.append(
                RuleViolation(message: "Confianza insuficiente")
            )
        }

        if discipline < minDiscipline {
            violations.append(
                RuleViolation(message: "Falta de disciplina")
            )
        }

        if value < minValue {
            violations.append(
                RuleViolation(message: "Valor percibido insuficiente")
            )
        }

        let finalScore = (confidence + discipline + value) / 3
        if finalScore < minFinalScore {
            violations.append(
                RuleViolation(message: "Puntuación final por debajo del mínimo")
            )
        }

        return violations
    }

    // DECISIÓN FINAL
    func canPlaceBet(violations: [RuleViolation]) -> Bool {
        violations.isEmpty
    }
}
