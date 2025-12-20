import UIKit

final class DecimalInputDelegate: NSObject, UITextFieldDelegate {

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if string.isEmpty {
            return true
        }

        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        let allowed = CharacterSet(charactersIn: "1234567890" + decimalSeparator)

        if string.rangeOfCharacter(from: allowed.inverted) != nil {
            return false
        }

        if string == decimalSeparator,
           let current = textField.text,
           current.contains(decimalSeparator) {
            return false
        }
        return true
    }
}
