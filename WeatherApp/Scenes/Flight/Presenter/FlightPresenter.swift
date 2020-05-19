import UIKit

protocol FlightPresentationLogic {
    func presentFlights(response: FlightModels.Popular.Response)
    func presentFailure(response: FlightModels.Failure.Response)
}

final class FlightPresenter: FlightPresentationLogic {
    
    weak var viewController: FlightDisplayLogic?
    
    private let dateFormatter = DateTimeFormatter()

    private let priceFormatter = PriceFormatter()
    
    // MARK: - Flights Presentation
    
    func presentFlights(response: FlightModels.Popular.Response) {
        let viewModel = FlightModels.Popular.ViewModel(flights: response.flights.map { flight in
            FlightModels.Popular.ViewModel.Item(
                identifier: flight.identifier,
                origin: flight.origin,
                destination: flight.destination,
                airlineName: flight.airlineName,
                airlineLogo: flight.airlineLogo,
                departureDate: flight.departureDate.flatMap { "Departure: \(dateFormatter.fullString(from: $0))" },
                returnDate: flight.returnDate.flatMap { "Return: \(dateFormatter.fullString(from: $0))" },
                price: priceFormatter.string(for: flight.price, currency: response.currency) ?? "N/A",
                transfers: "Transfers: \(flight.transfers > 0 ? String(flight.transfers) : "None")"
            )
        })
        viewController?.displayFlights(viewModel: viewModel)
    }
    
    func presentFailure(response: FlightModels.Failure.Response) {
        let errorMessage = "Something went wrong, please try again later ..."
        let viewModel = FlightModels.Failure.ViewModel(errorMessage: errorMessage)
        viewController?.displayFailure(response: viewModel)
    }
}
