import UIKit

final class ExpenseRowView: UIStackView {
    let expense: Expense
    let openExpense: (Expense) -> Void

    init(expense: Expense, openExpense: @escaping (Expense) -> Void) {
        self.expense = expense
        self.openExpense = openExpense
        super.init(frame: .zero)
        setup()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        let nameLabel = GenericText.make(text: expense.name, size: 17)
        let amountLabel = GenericText.make(text: expense.amount.formatted(.currency(code: "GBP")), size: 17)

        axis = .horizontal
        alignment = .fill
        distribution = .fillProportionally
        addArrangedSubview(nameLabel)
        addArrangedSubview(amountLabel)
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(navigateToExpense)))
    }

    @objc private func navigateToExpense() {
        openExpense(expense)
    }
}
