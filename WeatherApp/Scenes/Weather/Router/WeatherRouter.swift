import UIKit

protocol WeatherRoutingLogic {
}

protocol WeatherDataPassing {
    var dataStore: WeatherDataStore? { get set }
}

final class WeatherRouter: NSObject, WeatherRoutingLogic, WeatherDataPassing {
    
    weak var viewController: WeatherViewController?
    
    var dataStore: WeatherDataStore?
}
