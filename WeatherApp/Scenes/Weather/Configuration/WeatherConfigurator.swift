import UIKit

final class WeatherConfigurator: NSObject {
    
    @IBOutlet private weak var viewController: WeatherViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let asssembly = WeatherAssembly()
        asssembly.injectDependencies(for: viewController)
    }
}
