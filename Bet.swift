import Foundation

// MARK: - Resultado de la apuesta
enum BetResult: String, Codable, CaseIterable {
    case pending
    case win
    case loss
    case void
}

// MARK: - Modo de la apuesta
enum BetMode: String, Codable {
    case real
    case simulation
}

// MARK: - Modelo de apuesta
struct Bet: Identifiable, Codable {

    // MARK: - Identidad
    let id: UUID
    let date: Date

    // MARK: - Contexto
    let mode: BetMode
    let sport: String
    let competition: String

    // MARK: - Mercado
    let market: String
    let selection: String
    let odds: Double
    let stake: Double

    // MARK: - Gestión bancaria
    let bankBefore: Double?
    var bankAfter: Double?

    // MARK: - Estructura del pick
    let pickCount: Int

    // MARK: - Rúbrica
    let confidence: Int
    let disciplineScore: Int
    let valueScore: Int

    var finalScore: Int {
        (confidence + disciplineScore + valueScore) / 3
    }

    // MARK: - Resultado
    var result: BetResult

    // MARK: - Notas
    let notes: String?

    // MARK: - Init
    init(
        id: UUID = UUID(),
        date: Date = Date(),
        mode: BetMode,
        sport: String,
        competition: String,
        market: String,
        selection: String,
        odds: Double,
        stake: Double,
        bankBefore: Double?,
        pickCount: Int,
        confidence: Int,
        disciplineScore: Int,
        valueScore: Int,
        result: BetResult = .pending,
        notes: String? = nil
    ) {
        self.id = id
        self.date = date
        self.mode = mode
        self.sport = sport
        self.competition = competition
        self.market = market
        self.selection = selection
        self.odds = odds
        self.stake = stake
        self.bankBefore = bankBefore
        self.bankAfter = nil
        self.pickCount = pickCount
        self.confidence = confidence
        self.disciplineScore = disciplineScore
        self.valueScore = valueScore
        self.result = result
        self.notes = notes
    }
}
