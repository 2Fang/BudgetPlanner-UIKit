import UIKit

final class ExpenseTableCell: UITableViewCell {
    static let reuseIdentifier = "ExpenseTableCell"

    private var expense: Expense?
    private var openExpense: ((Expense) -> Void)?

    let nameLabel = GenericText.make(text: "asdf", size: 17)
    let amountLabel = GenericText.make(text: "fdas", size: 17)

    private let rowStack = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {

        rowStack.axis = .horizontal
        rowStack.alignment = .fill
        rowStack.distribution = .fillProportionally

        rowStack.addArrangedSubview(nameLabel)
        rowStack.addArrangedSubview(amountLabel)

        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        amountLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        contentView.addSubview(rowStack)
        contentView.isUserInteractionEnabled = true

        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(navigateToExpense)))

        rowStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            rowStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            rowStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            rowStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            rowStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    @objc private func navigateToExpense() {
        guard let openExpense, let expense else { return }
        openExpense(expense)
    }

    func configure(expense: Expense, openExpense: @escaping (Expense) -> Void) {
        self.expense = expense
        self.openExpense = openExpense
        nameLabel.text = expense.name
        amountLabel.text = expense.amount.formatted(.currency(code: "GBP"))
    }
}
