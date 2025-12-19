import Foundation

enum CustomDateFormatter {
    static var today: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM, YYYY"
        return formatter.string(from: Date())
    }
}
