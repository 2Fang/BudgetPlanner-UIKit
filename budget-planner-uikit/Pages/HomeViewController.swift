import UIKit

final class HomeViewController: UIViewController {

    private let stackView = UIStackView()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Budget Planner"
        label.font = .systemFont(ofSize: 36, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .logo)
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        return imageView
    }()

    private let addExpenseButton: UIButton = GenericButton.make(title: "Add Expense")

    private let viewExpensesButton: UIButton = GenericButton.make(title: "View Expenses")

    private let settingsButton: UIButton =  GenericButton.make(title: "Settings")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        setupActions()
    }

    private func setupLayout() {
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .fill

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(logoImageView)
        [addExpenseButton, viewExpensesButton, settingsButton].forEach { button in
            stackView.addArrangedSubview(button)
        }

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupActions() {
        addExpenseButton.addTarget(self, action: #selector(onAddExpenseClicked), for: .touchUpInside)
        viewExpensesButton.addTarget(self, action: #selector(onViewExpensesClicked), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(onSettingsClicked), for: .touchUpInside)
    }

    @objc private func onAddExpenseClicked() {
        print("clicked add expense")
    }

    @objc private func onViewExpensesClicked() {
        print("clicked view expenses")
    }

    @objc private func onSettingsClicked() {
        print("clicked settings")
    }
}
