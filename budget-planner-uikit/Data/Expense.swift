import Foundation
import SwiftData

@Model
final class Expense {
    var name: String
    var pennies: Int
    var createdAt: Date

    var amount: Decimal {
        .init(pennies) / 100
    }

    init(name: String, pennies: Int, createdAt: Date = Date()) {
        self.name = name
        self.pennies = pennies
        self.createdAt = createdAt
    }
}
