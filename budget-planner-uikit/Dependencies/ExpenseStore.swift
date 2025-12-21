import Foundation
import SwiftData

final class ExpenseStore {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func add(name: String, amount: Decimal, createdAt: Date = Date()) throws {
        let intAmount = Int(truncating: NSDecimalNumber(decimal: amount * 100))
        let expense = Expense(name: name, pennies: intAmount, createdAt: createdAt)
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

    func fetchBy(date: Date) throws -> [Expense] {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: date)
        guard let end = calendar.date(byAdding: .day, value: 1, to: start) else {
            return []
        }

        let descriptor = FetchDescriptor<Expense>(
            predicate: #Predicate<Expense> { expense in
                expense.createdAt >= start && expense.createdAt < end
            },
            sortBy: [SortDescriptor(\Expense.createdAt, order: .reverse)]
        )

        return try context.fetch(descriptor)
    }

    func delete(_ expense: Expense) throws {
        context.delete(expense)
        try context.save()
    }
}
