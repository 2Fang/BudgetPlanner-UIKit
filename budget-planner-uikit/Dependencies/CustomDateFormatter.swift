import Foundation

enum CustomDateFormatter {
    static func date(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM, YYYY"
        return formatter.string(from: date)
    }

    static var today: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM, YYYY"
        return formatter.string(from: Date())
    }
}
