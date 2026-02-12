import Foundation

enum BetResult: String, Codable, CaseIterable {
    case pending
    case win
    case loss
    case void
}

enum BetMode: String, Codable, CaseIterable {
    case real
    case simulation
}

struct Bet: Identifiable, Codable {
    // Identidad
    let id: UUID
    let date: Date

    // Contexto
    let mode: BetMode
    let sport: String
    let competition: String

    // Mercado
    let market: String
    let selection: String
    let odds: Double

    // Gestión
    let stake: Double
    let bankBefore: Double

    // Resultado
    var result: BetResult
    var bankAfter: Double?

    // Rúbrica
    let picksCount: Int
    let confidence: Int        // 1–10
    let disciplineScore: Int   // 1–10
    let valueScore: Int        // 1–10
    let finalScore: Int        // media o ponderado

    // Notas
    let notes: String?

    init(
        mode: BetMode,
        sport: String,
        competition: String,
        market: String,
        selection: String,
        odds: Double,
        stake: Double,
        bankBefore: Double,
        picksCount: Int,
        confidence: Int,
        disciplineScore: Int,
        valueScore: Int,
        notes: String? = nil
    ) {
        self.id = UUID()
        self.date = Date()
        self.mode = mode
        self.sport = sport
        self.competition = competition
        self.market = market
        self.selection = selection
        self.odds = odds
        self.stake = stake
        self.bankBefore = bankBefore
        self.result = .pending
        self.bankAfter = nil
        self.picksCount = picksCount
        self.confidence = confidence
        self.disciplineScore = disciplineScore
        self.valueScore = valueScore
        self.finalScore = (confidence + disciplineScore + valueScore) / 3
        self.notes = notes
    }
}
