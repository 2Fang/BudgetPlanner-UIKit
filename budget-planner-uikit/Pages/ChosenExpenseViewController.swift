import UIKit

final class ChosenExpenseViewController: UIViewController {
    let stackView = UIStackView()

    let expense: Expense
    let expenseStore: ExpenseStore

    let nameLabel: UILabel
    let amountLabel: UILabel
    let dateLabel: UILabel

    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        button.setImage(UIImage(systemName: "trash.icon"), for: .normal)
        button.tintColor = .systemRed
        return button
    }()

    init(expense: Expense, expenseStore: ExpenseStore) {
        self.expense = expense
        self.expenseStore = expenseStore
        self.nameLabel = GenericText.make(text: expense.name, size: 32)
        self.amountLabel = GenericText.make(text: "Cost: " + expense.amount.formatted(.currency(code: "GBP")), size: 24)
        self.dateLabel = GenericText.make(text: CustomDateFormatter.date(from: expense.createdAt), size: 24)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
    }

    private func setupLayout() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20

        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(amountLabel)
        stackView.addArrangedSubview(dateLabel)

        setupDeleteButton()

        stackView.addArrangedSubview(deleteButton)

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])


    }

    private func setupDeleteButton() {
        deleteButton.addTarget(self, action: #selector(deleteExpense), for: .touchUpInside)
    }

    @objc private func deleteExpense() {
        do {
            try expenseStore.delete(expense)
            presentOKAlert(title: "Success!", message: "Expense Deleted") {
                self.navigationController?.popViewController(animated: true)
            }
        } catch {
            presentOKAlert(title: "Error!", message: "Could not delete expense: \(error.localizedDescription)")
        }
    }
}
