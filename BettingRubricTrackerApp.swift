import SwiftUI

@main
struct BettingRubricTrackerApp: App {

    @StateObject var appState = AppState()

    init() {
        NotificationManager.shared.requestPermission()
        DailyReviewNotifier.schedule()
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(appState)
        }
    }
}
