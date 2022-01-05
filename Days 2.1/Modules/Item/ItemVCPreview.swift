#if DEBUG
import SwiftUI

struct ItemVCRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let itemVC = ItemViewController()
        ItemConfigurator.configure(with: itemVC)
        return itemVC
    }

    func updateUIViewController(
        _ uiViewController: UIViewController,
        context: Context
    ) {}
}

struct ItemVCPreview: PreviewProvider {
    static var previews: some View {
        ItemVCRepresentable()
    }
}
#endif
