import Foundation

extension Calendar {
    func numberOfDaysBetween(_ date1: Date, and date2: Date) -> Int {
        var result = Int.zero
        if let number = dateComponents([.day], from: date1, to: date2).day {
            result = number
        }
        return result
    }
}
