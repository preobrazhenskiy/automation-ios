import UIKit

protocol FlightDisplayLogic: class {
    func displayFlights(viewModel: FlightModels.Popular.ViewModel)
    func displayFailure(response: FlightModels.Failure.ViewModel)
}

final class FlightViewController: UIViewController {
    
    var interactor: FlightBusinessLogic?
    var router: (NSObjectProtocol & FlightRoutingLogic & FlightDataPassing)?
    
    // MARK: Data
    
    private var flights: [FlightCellViewModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: Views
    
    @IBOutlet private var collectionView: UICollectionView!
    
    private let numberOfVerticalItems = 2
    
    private let minItemHeight: CGFloat = 120
}

// MARK: - System

extension FlightViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Private

extension FlightViewController {
    
    private func setup() {
        setupUI()
        let request = FlightModels.Popular.Request()
        interactor?.loadData(request: request)
    }
    
    private func setupUI() {
        view.backgroundColor = .background
        collectionView.register(FlightCellViewModel.self)
    }
}

// MAKR: - Collection View

// MARK: Data Source
extension FlightViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flights.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(with: itemModel(at: indexPath), for: indexPath)
    }
    
    private func itemModel(at indexPath: IndexPath) -> FlightCellViewModel {
        return flights[indexPath.item]
    }
}

// MARK: Delegate
extension FlightViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        let horizontalInset = layout.sectionInset.left + layout.sectionInset.right
        let width = collectionView.bounds.width - horizontalInset
        
        let verticalInset = layout.sectionInset.top + layout.sectionInset.bottom
        let height = (collectionView.bounds.height - verticalInset) / CGFloat(numberOfVerticalItems) - layout.minimumLineSpacing
        
        return CGSize(width: width, height: max(height, minItemHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellModel = itemModel(at: indexPath)
        let request = FlightModels.SelectFlight.Request(identifier: cellModel.identifier)
        interactor?.selectFlight(request: request)
        router?.routeToWeather()
    }
}

// MARK: - Display logic

extension FlightViewController: FlightDisplayLogic {
    
    func displayFlights(viewModel: FlightModels.Popular.ViewModel) {
        flights = viewModel.flights.map {
            FlightCellViewModel(
                identifier: $0.identifier,
                origin: $0.origin,
                destination: $0.destination,
                airlineName: $0.airlineName,
                airlineLogo: $0.airlineLogo,
                departureDate: $0.departureDate,
                returnDate: $0.returnDate,
                price: $0.price,
                transfers: $0.transfers
            )
        }
    }
    
    func displayFailure(response: FlightModels.Failure.ViewModel) {
        flights = []
    }
}
