import Foundation
import SwiftData

@Model
final class Expense {
    var name: String
    var amount: Int
    var createdAt: Date

    init(name: String, amount: Int, createdAt: Date = Date()) {
        self.name = name
        self.amount = amount
        self.createdAt = createdAt
    }
}
