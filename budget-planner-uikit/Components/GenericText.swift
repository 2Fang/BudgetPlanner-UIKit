import UIKit

enum GenericText {
    static func make(
        text: String,
        size: CGFloat,
        weight: UIFont.Weight = .regular,
        alignment: NSTextAlignment = .center,
        noLines: Int = 0
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: size, weight: weight)
        label.textAlignment = alignment
        label.numberOfLines = noLines
        return label
    }
}
