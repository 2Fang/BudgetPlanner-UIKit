import UIKit

final class ExpensesViewController: UIViewController {

    let stackView = UIStackView()

    let titleLabel: UILabel = GenericText.make(text: "Expenses", size: 36, weight: .bold)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
    }

    private func setupLayout() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        
        stackView.addArrangedSubview(titleLabel)

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
