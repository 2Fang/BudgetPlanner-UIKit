import UIKit

final class AddExpenseViewController: UIViewController {
    private let expenseStore: ExpenseStore
    private let amountInputDelegate = DecimalInputDelegate()

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

    private let saveButton = GenericButton.make(title: "Save")

    init(expenseStore: ExpenseStore) {
        self.expenseStore = expenseStore
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        amountTextField.delegate = amountInputDelegate
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

        setupSaveButton()
        stackView.addArrangedSubview(saveButton)

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

    private func setupSaveButton() {
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    @objc private func saveButtonTapped() {
        let name = (expenseTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        if name == "" {
            presentAlert(.missingExpenseName)
            return
        }
        let amountString = (amountTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        guard let amount = Decimal(string: amountString) else {
            presentAlert(.invalidAmount)
            return
        }
        do {
          try expenseStore.add(name: name, amount: amount)
        } catch {
            presentAlert(.saveFailed(message: error.localizedDescription))
        }
        presentAlert(.successFulSave)
    }

    private func presentAlert(_ alert: ExpenseAlert) {
        presentOKAlert(title: alert.title, message: alert.message)
    }
}
