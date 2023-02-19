import CoreGraphics

struct Layout {
    enum Button {
        static let height = CGFloat(48)
    }

    enum Insets {
        static let standard = CGFloat(16)
        static let average = standard / 2
        static let small = standard / 4
    }
}
