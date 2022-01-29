@testable import Days_2_1

final class MainRouterMock: MainRouterProtocol {
    var isNextViewPresented = false
    func openItemViewController() {
        isNextViewPresented.toggle()
    }
}
