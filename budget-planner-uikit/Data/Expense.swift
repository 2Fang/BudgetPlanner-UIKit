import Foundation
import SwiftData

@Model
final class Expense {
    var name: String
    var amount: Decimal
    var createdAt: Date

    init(name: String, amount: Decimal, createdAt: Date = Date()) {
        self.name = name
        self.amount = amount
        self.createdAt = createdAt
    }
}
