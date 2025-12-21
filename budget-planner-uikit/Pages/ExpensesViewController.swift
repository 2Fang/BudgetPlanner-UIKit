import UIKit

final class ExpensesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExpenseTableCell.reuseIdentifier, for: indexPath) as! ExpenseTableCell
        cell.configure(expense: expenses[indexPath.row], openExpense: openExpense(_:))
        return cell
    }
    

    private let expenseStore: ExpenseStore

    private let stackView = UIStackView()

    private let titleLabel: UILabel = GenericText.make(text: "Expenses", size: 36, weight: .bold)

    private var selectedDate = Date() {
        didSet {
            updateDate()
        }
    }
    private let dateLabel: UILabel = GenericText.make(text: "", size: 28, weight: .semibold)

    private let yesterdayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrowshape.turn.up.left.fill"), for: .normal)
        return button
    }()

    private let tomorrowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrowshape.turn.up.right.fill"), for: .normal)
        return button
    }()

    private let dateStackView = UIStackView()
    private let expensesView = UITableView()
    private var expenses: [Expense] = []


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
        setExpenseTable()
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

    private func setExpenseTable() {
        expensesView.dataSource = self
        expensesView.delegate = self
        expensesView.register(ExpenseTableCell.self, forCellReuseIdentifier: ExpenseTableCell.reuseIdentifier)
    }

    private func resetExpenses() {
        expenses = (try? expenseStore.fetchBy(date: selectedDate)) ?? []
        expensesView.reloadData()
    }

    private func makeExpenseView(expense: Expense) -> UITableViewCell {
        return ExpenseTableCell()
    }

    private func updateDate() {
        dateLabel.text = CustomDateFormatter.date(from: selectedDate)
        resetExpenses()
    }

    private func openExpense(_ expense: Expense) {
        let expenseViewController = ChosenExpenseViewController(expense: expense, expenseStore: expenseStore)
        navigationController?.pushViewController(expenseViewController, animated: true)
    }

    @objc private func yesterdayTapped() {
        selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate)!
    }

    @objc private func tomorrowTapped() {
        selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!
    }
}
