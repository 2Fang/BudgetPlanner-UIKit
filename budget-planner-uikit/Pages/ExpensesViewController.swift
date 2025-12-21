import UIKit

final class ExpensesViewController: UIViewController {

    let expenseStore: ExpenseStore

    let stackView = UIStackView()

    let titleLabel: UILabel = GenericText.make(text: "Expenses", size: 36, weight: .bold)

    var selectedDate = Date() {
        didSet {
            updateDate()
        }
    }
    let dateLabel: UILabel = GenericText.make(text: "", size: 28, weight: .semibold)

    let yesterdayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrowshape.turn.up.left.fill"), for: .normal)
        return button
    }()

    let tomorrowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrowshape.turn.up.right.fill"), for: .normal)
        return button
    }()

    let dateStackView = UIStackView()
    let expensesView = UIStackView()

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
        updateDate()
        setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateDate()
    }


    private func setupLayout() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually

        setupDayStack()

        stackView.addArrangedSubview(dateStackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(expensesView)

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupDayStack() {
        dateStackView.axis = .horizontal
        dateStackView.alignment = .center
        dateStackView.distribution = .fillProportionally

        dateStackView.addArrangedSubview(yesterdayButton)
        dateStackView.addArrangedSubview(dateLabel)
        dateStackView.addArrangedSubview(tomorrowButton)

        yesterdayButton.addTarget(self, action: #selector(yesterdayTapped), for: .touchUpInside)
        tomorrowButton.addTarget(self, action: #selector(tomorrowTapped), for: .touchUpInside)
    }

    private func setExpenses() {
        expensesView.axis = .vertical
        expensesView.alignment = .fill
        expensesView.distribution = .fillEqually

        guard let expenses = try? expenseStore.fetchBy(date: selectedDate) else {
            return
        }
        expensesView.arrangedSubviews.forEach { subview in
            expensesView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        for expense in expenses {
            expensesView.addArrangedSubview(makeExpenseView(expense: expense))
        }
    }

    private func makeExpenseView(expense: Expense) -> UIStackView {
        print(expense.name)
        let stackView = ExpenseRowView(expense: expense, openExpense: openExpense(_:))

        return stackView

    }

    private func updateDate() {
        dateLabel.text = CustomDateFormatter.date(from: selectedDate)
        setExpenses()
    }

    private func openExpense(_ expense: Expense) {
        let expenseViewController = ExpenseViewController(expense: expense, expenseStore: expenseStore)
        navigationController?.pushViewController(expenseViewController, animated: true)
    }

    @objc private func yesterdayTapped() {
        selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate)!
    }

    @objc private func tomorrowTapped() {
        selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!
    }
}
