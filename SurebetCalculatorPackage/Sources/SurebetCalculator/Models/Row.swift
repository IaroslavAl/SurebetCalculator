import Foundation

struct Row: Equatable {
    let id: Int
    var isON = false
    var betSize = ""
    var coefficient = ""
    var income = "0"

    static func createRows(_ number: Int = 4) -> [Row] {
        (0..<number).map { Row(id: $0) }
    }
}