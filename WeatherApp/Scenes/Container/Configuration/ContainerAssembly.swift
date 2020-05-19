import UIKit

final class ContainerAssembly {
    
    func injectDependencies(for viewController: ContainerViewController) {
        let interactor = ContainerInteractor()
        
        let router = ContainerRouter()
        viewController.router = router
        
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    static func initializeFromStoryboard() -> ContainerViewController {
        return Storyboards.main.instantiateViewController()
    }
}
