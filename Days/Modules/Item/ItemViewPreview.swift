#if DEBUG
import SwiftUI

struct ItemVCRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        ItemConfigurator.configure(with: nil)
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
