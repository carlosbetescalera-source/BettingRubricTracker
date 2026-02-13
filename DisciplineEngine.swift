import Foundation

// MARK: - Advertencia de disciplina
struct DisciplineWarning: Identifiable {
    let id = UUID()
    let message: String
}

// MARK: - Motor de disciplina
struct DisciplineEngine {

    static func evaluate(
        bank: Double,
        stake: Double,
        odds: Double,
        score: Int
    ) -> [DisciplineWarning] {

        var warnings: [DisciplineWarning] = []

        // Stake demasiado alto
        if stake > bank * 0.06 {
            warnings.append(
                DisciplineWarning(
                    message: "El stake supera el 6% del bank."
                )
            )
        }

        // Cuota baja con score bajo
        if odds < 1.50 && score <= 7 {
            warnings.append(
                DisciplineWarning(
                    message: "Cuota baja con score ajustado."
                )
            )
        }

        // Score mínimo
        if score < 7 {
            warnings.append(
                DisciplineWarning(
                    message: "El score es inferior al mínimo recomendado."
                )
            )
        }

        return warnings
    }
}
