import Foundation

struct Bet: Identifiable {
    let id = UUID()
    var competition: String = ""
    var match: String = ""
    var market: String = "+0.5 equipo"
    var odds: Double = 1.50
    var stake: Double = 0

    var context: Int = 0
    var offense: Int = 0
    var rival: Int = 0
    var marketFit: Int = 0
    var discipline: Int = 0

    var totalScore: Int {
        context + offense + rival + marketFit + discipline
    }
}
