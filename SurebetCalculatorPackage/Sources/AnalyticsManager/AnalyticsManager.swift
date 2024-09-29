import AppMetricaCore
import Foundation

public struct AnalyticsManager {
    public static func log(name: String, parameters: [AnyHashable: Any]? = nil) {
    #if !DEBUG
        AppMetrica.reportEvent(name: name, parameters: parameters)
    #endif
    }
}
