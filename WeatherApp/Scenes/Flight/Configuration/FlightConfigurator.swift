import UIKit

final class FlightConfigurator: NSObject {
    
    @IBOutlet private weak var viewController: FlightViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let asssembly = FlightAssembly()
        asssembly.injectDependencies(for: viewController)
    }
}
