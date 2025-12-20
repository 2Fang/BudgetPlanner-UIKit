import UIKit

final class AddExpenseViewController: UIViewController {

    private let stackView: UIStackView = UIStackView()
    private let expenseRowStack = UIStackView()
    private let amountRowStack = UIStackView()

    private let titleLabel: UILabel = GenericText.make(text: "Add Expense", size: 36, weight: .bold)
    private let dateLabel: UILabel = GenericText.make(text: CustomDateFormatter.today, size: 24, weight: .semibold)
    private let expenseLabel: UILabel = GenericText.make(text: "Expense: ", size: 17)
    private let amountLabel: UILabel = GenericText.make(text: "Amount: ", size: 17)

    private let expenseTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Expense"
        textField.font = .systemFont(ofSize: 17, weight: .regular)
        textField.autocapitalizationType = .words
        textField.returnKeyType = .next
        return textField
    }()

    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Amount"
        textField.font = .systemFont(ofSize: 17, weight: .regular)
        textField.keyboardType = .decimalPad
        textField.returnKeyType = .done
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
    }

    private func setupLayout() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 24

        setupExpenseSubView()
        setupAmountSubView()

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(expenseRowStack)
        stackView.addArrangedSubview(amountRowStack)

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupExpenseSubView() {
        expenseRowStack.axis = .horizontal
        expenseRowStack.alignment = .center
        expenseRowStack.spacing = 16
        expenseRowStack.addArrangedSubview(expenseLabel)
        expenseRowStack.addArrangedSubview(expenseTextField)
    }

    private func setupAmountSubView() {
        amountRowStack.axis = .horizontal
        amountRowStack.alignment = .center
        amountRowStack.spacing = 16
        amountRowStack.addArrangedSubview(amountLabel)
        amountRowStack.addArrangedSubview(amountTextField)
    }

}
