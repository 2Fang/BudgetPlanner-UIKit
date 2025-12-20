import UIKit

extension UIViewController {
    func presentOKAlert(title: String, message: String, onOK: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            onOK?()
        })
        present(alert, animated: true)
    }
}
