import Foundation

struct RubricEngine {

    static func decision(score: Int) -> RubricDecision {
        if score >= 7 {
            return .bet
        } else {
            return .noBet
        }
    }
}

enum RubricDecision {
    case bet
    case noBet
}
