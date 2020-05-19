import UIKit

protocol FlightRoutingLogic {
    func routeToWeather()
}

protocol FlightDataPassing {
    var dataStore: FlightDataStore? { get set }
    var delegate: FlightDelegate? { get set }
}

protocol FlightDelegate: class {
    func showWeather(for city: City)
}

final class FlightRouter: NSObject, FlightRoutingLogic, FlightDataPassing {
    
    weak var viewController: FlightViewController?
    
    weak var delegate: FlightDelegate?
    
    var dataStore: FlightDataStore?
    
    // MARK: - Routing
    
    func routeToWeather() {
        guard let city = dataStore?.selectedDestinationCity else {
            return
        }
        delegate?.showWeather(for: city)
    }
}
