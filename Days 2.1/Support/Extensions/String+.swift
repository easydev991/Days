import Foundation

extension String {
    var containsLetter: Bool {
        !(rangeOfCharacter(from: .letters)?.isEmpty ?? true)
    }
}
