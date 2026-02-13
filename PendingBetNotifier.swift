import Foundation
import UserNotifications

struct PendingBetNotifier {

    static func schedule(for betId: UUID) {
        let content = UNMutableNotificationContent()
        content.title = "Apuesta pendiente"
        content.body = "Tienes una apuesta sin resolver desde hace 24 horas."

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 60 * 60 * 24,
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: betId.uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }

    static func cancel(for betId: UUID) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(
                withIdentifiers: [betId.uuidString]
            )
    }
}
