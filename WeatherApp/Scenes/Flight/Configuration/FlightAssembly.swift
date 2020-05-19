import UIKit

final class FlightAssembly {
    
    func injectDependencies(for viewController: FlightViewController) {
        let networkClient = URLSessionNetworkClient()
        let flightWorker = FlightWorkerImpl(client: networkClient)
        let cityWorker = CityWorkerImpl(client: networkClient)
        let airlineWorker = AirlineWorkerImpl(client: networkClient, logoBuilder: AirlineLogoBuilderImpl())
        let settingsStorage = SettingsStorageServiceImpl(storage: UserDefaultsStorage())
        
        let presenter = FlightPresenter()
        let interactor = FlightInteractor(presenter: presenter,
                                          flightWorker: flightWorker,
                                          cityWorker: cityWorker,
                                          airlineWorker: airlineWorker,
                                          settingsStorage: settingsStorage)
        let router = FlightRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        
        presenter.viewController = viewController
        
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    static func initializeFromStoryboard() -> FlightViewController {
        return Storyboards.main.instantiateViewController()
    }
}
