enum ExpenseAlert {
    case successFulSave
    case missingExpenseName
    case invalidAmount
    case saveFailed(message: String)

    var title: String {
        switch self {
        case .successFulSave:
            return "Success"
        case .missingExpenseName:
            return "Missing Expense Name"
        case .invalidAmount:
            return "Invalid Amount"
        case .saveFailed:
            return "Save Failed"
        }
    }

    var message: String {
        switch self {
        case .successFulSave:
            return "Expense saved successfully."
        case .missingExpenseName:
            return "Please enter an expense name."
        case .invalidAmount:
            return "Please enter a valid amount greater than 0."
        case .saveFailed(message: let message):
            return message
        }
    }
}
