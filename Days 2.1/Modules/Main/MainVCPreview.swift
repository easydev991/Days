import SwiftUI

struct NavControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateInitialViewController()!
    }

    func updateUIViewController(
        _ uiViewController: UINavigationController,
        context: Context
    ) {}
}

struct MainVCPreview: PreviewProvider {
    static var previews: some View {
        Group {
            NavControllerRepresentable()
                .preferredColorScheme(.dark)
        }
    }
}
