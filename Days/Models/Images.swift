import UIKit.UIImage

enum Images {
    enum TabBar {
        case home
        case settings

        var image: UIImage? {
            switch self {
            case .home:
                return .init(systemName: "house.fill")
            case .settings:
                return .init(systemName: "gear")
            }
        }
    }

    enum Main {
        case sort

        var image: UIImage? {
            switch self {
            case .sort:
                return .init(systemName: "arrow.up.arrow.down")
            }
        }
    }
}
