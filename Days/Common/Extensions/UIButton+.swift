import UIKit

extension UIButton {
    static func sunflowerStyle(title: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.clipsToBounds = true
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(
            ofSize: 16,
            weight: .medium
        )
        button.setBackgroundImage(
            .init(color: .sunflower),
            for: .normal
        )
        button.setBackgroundImage(
            .init(color: .sunflowerPressed),
            for: .highlighted
        )
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.blackPressed, for: .highlighted)
        button.layer.cornerRadius = 24
        button.contentEdgeInsets = .init(
            top: .zero,
            left: Layout.Insets.standard,
            bottom: .zero,
            right: Layout.Insets.standard
        )
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }
}
