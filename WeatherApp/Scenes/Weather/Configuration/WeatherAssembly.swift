import UIKit

final class WeatherAssembly {
    
    func injectDependencies(for viewController: WeatherViewController) {
        let networkClient = URLSessionNetworkClient()
        let weatherWorker = WeatherWorkerImpl(client: networkClient, iconBuilder: WeatherIconBuilderImpl())
        
        let presenter = WeatherPresenter()
        let interactor = WeatherInteractor(presenter: presenter, weatherWorker: weatherWorker)
        let router = WeatherRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        
        presenter.viewController = viewController
        
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    static func initializeFromStoryboard() -> WeatherViewController {
        return Storyboards.main.instantiateViewController()
    }
}
