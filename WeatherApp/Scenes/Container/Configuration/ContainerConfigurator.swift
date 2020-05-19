import UIKit

final class ContainerConfigurator: NSObject {
    
    @IBOutlet private weak var viewController: ContainerViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let asssembly = ContainerAssembly()
        asssembly.injectDependencies(for: viewController)
    }
}
