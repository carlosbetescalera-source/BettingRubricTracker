import Foundation
import UserNotifications

struct DailyReviewNotifier {

    static func schedule() {
        let content = UNMutableNotificationContent()
        content.title = "Revisión diaria"
        content.body = "Revisa tus apuestas, estadísticas y disciplina."

        var date = DateComponents()
        date.hour = 22
        date.minute = 0

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: date,
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: "daily_review",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }
}
