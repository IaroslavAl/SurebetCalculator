import AppMetricaCore
import Foundation

public struct AnalyticsManager {
    public static func log(name: String, parameters: [AnyHashable: Any]? = nil) {
        AppMetrica.reportEvent(name: name, parameters: parameters)
    }
}
