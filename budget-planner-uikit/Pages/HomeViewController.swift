import UIKit

final class HomeViewController: UIViewController {

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

    private let addExpenseButton: UIButton = makeButton(title: "Add Expense")

    private let viewExpensesButton: UIButton = makeButton(title: "View Expenses")

    private let settingsButton: UIButton =  makeButton(title: "Settings")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        setupActions()
    }

    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            logoImageView,
            addExpenseButton,
            viewExpensesButton,
            settingsButton
        ])

        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .fill

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

    private static func makeButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
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
