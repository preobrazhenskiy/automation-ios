import UIKit

protocol ContainerRoutingLogic {
    func embedContent(flightContainerView: UIView, weatherContainerView: UIView)
}

protocol ContainerDataPassing {
    var dataStore: ContainerDataStore? { get set }
}

final class ContainerRouter: NSObject, ContainerRoutingLogic, ContainerDataPassing {
    
    weak var viewController: ContainerViewController?
    
    var dataStore: ContainerDataStore?
    
    // MARK: - Routing
    
    func embedContent(flightContainerView: UIView, weatherContainerView: UIView) {
        guard let viewController = viewController, let dataStore = dataStore else {
            return
        }
        let flightsViewController = FlightAssembly.initializeFromStoryboard()
        passDataToFlights(source: dataStore, destination: &flightsViewController.router!.dataStore!)
        navigateToFlights(source: viewController, destination: flightsViewController, in: flightContainerView)
        
        let weatherViewController = WeatherAssembly.initializeFromStoryboard()
        passDataToWeather(source: dataStore, destination: &weatherViewController.router!.dataStore!)
        navigateToWeather(source: viewController, destination: weatherViewController, in: weatherContainerView)
        
        flightsViewController.router?.delegate = weatherViewController.interactor
    }
    
    // MARK: - Navigation
    
    func navigateToFlights(source: ContainerViewController, destination: FlightViewController, in containerView: UIView) {
        source.showContentViewController(destination, in: containerView)
    }
    
    func navigateToWeather(source: ContainerViewController, destination: WeatherViewController, in containerView: UIView) {
        source.showContentViewController(destination, in: containerView)
    }
    
    // MARK: - Passing data
    
    func passDataToFlights(source: ContainerDataStore, destination: inout FlightDataStore) {
        destination.originCity = source.originCity
    }
    
    func passDataToWeather(source: ContainerDataStore, destination: inout WeatherDataStore) {
        
    }
}
