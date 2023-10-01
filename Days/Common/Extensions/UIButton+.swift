import UIKit

extension UIButton {
    enum CustomStyle {
        case sunflower, dangerRed
    }

    static func makeButton(
        title: String,
        style: CustomStyle = .sunflower
    ) -> UIButton {
        let button = UIButton(type: .custom)
        button.clipsToBounds = true
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(
            ofSize: 16,
            weight: .medium
        )
        button.setBackgroundImage(
            .init(color: style == .sunflower ? .sunflower : .red),
            for: .normal
        )
        button.setBackgroundImage(
            .init(color: style == .sunflower ? .sunflowerPressed : .redPressed),
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
