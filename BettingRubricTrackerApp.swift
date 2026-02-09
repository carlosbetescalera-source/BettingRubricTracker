import SwiftUI

@main
struct BettingRubricTrackerApp: App {
    @StateObject var appState = AppState()
    @StateObject var rulesEngine = RulesEngine()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .environmentObject(appState)
                    .environmentObject(rulesEngine)
            }
        }
    }
}
