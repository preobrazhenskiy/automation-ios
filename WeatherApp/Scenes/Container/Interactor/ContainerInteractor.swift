import UIKit

protocol ContainerDataStore {
    var originCity: City? { get set }
}

final class ContainerInteractor: ContainerDataStore {
    var originCity: City?
}
