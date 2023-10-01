import UIKit.UIImage

extension UIImage {
    func colored(_ color: UIColor) -> UIImage {
        UIGraphicsImageRenderer(size: size).image { context in
            color.setFill()
            self.draw(at: .zero)
            context.fill(
                CGRect(
                    x: .zero,
                    y: .zero,
                    width: size.width,
                    height: size.height
                ),
                blendMode: .sourceAtop
            )
        }
    }
}

extension UIImage {
    convenience init?(
        color: UIColor,
        size: CGSize = .init(width: 1, height: 1)
    ) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, .zero)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
