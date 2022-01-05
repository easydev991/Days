#if DEBUG
import SwiftUI

struct MainVCRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let mainVC = MainViewController()
        MainConfigurator.configure(with: mainVC)
        let navigationController = UINavigationController(rootViewController: mainVC)
        return navigationController
    }

    func updateUIViewController(
        _ uiViewController: UIViewController,
        context: Context
    ) {}
}

struct MainVCPreview: PreviewProvider {
    static var previews: some View {
        MainVCRepresentable()
    }
}
#endif
