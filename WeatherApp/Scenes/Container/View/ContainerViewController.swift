import UIKit

final class ContainerViewController: UIViewController {
    
    var router: (NSObjectProtocol & ContainerRoutingLogic & ContainerDataPassing)?
    
    // MARK: Views
    
    @IBOutlet private var flightsContainerView: UIView!
    
    @IBOutlet private var weatherContainerView: UIView!
}

// MARK: - System

extension ContainerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Private

extension ContainerViewController {
    
    func setup() {
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.title = "Choose Your Flight"
        router?.embedContent(flightContainerView: flightsContainerView, weatherContainerView: weatherContainerView)
    }
}
