import UIKit.UIImage

enum Images {
    enum TabBar {
        case home
        case settings

        var image: UIImage? {
            switch self {
            case .home:
                .init(systemName: "house.fill")
            case .settings:
                .init(systemName: "gear")
            }
        }
    }

    enum Main {
        case sort

        var image: UIImage? {
            switch self {
            case .sort:
                .init(systemName: "arrow.up.arrow.down")
            }
        }
    }
}
