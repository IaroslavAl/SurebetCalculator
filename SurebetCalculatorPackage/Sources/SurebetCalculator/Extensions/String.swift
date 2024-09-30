import Foundation

public extension String {
    func formatToDouble() -> Double? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        if let formattedValue = formatter.number(from: self) {
            return formattedValue.doubleValue
        }
        return nil
    }

    func isValidDouble() -> Bool {
        self.formatToDouble() != nil
        || self.isEmpty
        || self.formatToDouble() ?? 0 > 0
    }
}
