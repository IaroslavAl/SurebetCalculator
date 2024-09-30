import Foundation

enum FocusableField: Hashable {
    case totalBetSize
    case rowBetSize(_ id: Int)
    case rowCoefficient(_ id: Int)
}
