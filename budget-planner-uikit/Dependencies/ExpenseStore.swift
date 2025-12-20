import Foundation
import SwiftData

final class ExpenseStore {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func add(name: String, amount: Decimal, createdAt: Date = Date()) throws {
        let intAmount = Int(truncating: NSDecimalNumber(decimal: amount * 100))
        let expense = Expense(name: name, amount: intAmount, createdAt: createdAt)
        context.insert(expense)
        try context.save()
    }

    func fetchAll() throws -> [Expense] {
        let descriptor = FetchDescriptor<Expense>(
            sortBy: [SortDescriptor(\Expense.createdAt, order: .reverse)]
        )
        return try context.fetch(descriptor)
    }

    func fetchBy(name: String) throws -> [Expense] {
        let descriptor = FetchDescriptor<Expense>(
            predicate: #Predicate { $0.name == name },
            sortBy: [SortDescriptor(\Expense.createdAt, order: .reverse)]
        )
        return try context.fetch(descriptor)
    }
}
