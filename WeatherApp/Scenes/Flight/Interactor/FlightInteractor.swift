import UIKit

protocol FlightBusinessLogic {
    func loadData(request: FlightModels.Popular.Request)
    func selectFlight(request: FlightModels.SelectFlight.Request)
}

protocol FlightDataStore {
    var originCity: City? { get set }
    var selectedDestinationCity: City? { get }
}

enum FlightBusinessLogicError: Error {
    case originCityNotSelected
}

final class FlightInteractor: FlightBusinessLogic, FlightDataStore {
    
    private let presenter: FlightPresentationLogic
    
    // MARK: Workers
    
    private let flightWorker: FlightWorker
    
    private let cityWorker: CityWorker
    
    private let airlineWorker: AirlineWorker
    
    // MARK: Storage
    
    private let settingsStorage: SettingsStorageService
    
    // MARK: Data Store
    
    private var flights: [Int: Flight]?
    
    private var cities: [String: City]?
    
    private var airlines: [String: City]?
    
    var originCity: City?
    
    private(set) var selectedDestinationCity: City?
    
    // MARK: - Init
    
    init(presenter: FlightPresentationLogic,
         flightWorker: FlightWorker,
         cityWorker: CityWorker,
         airlineWorker: AirlineWorker,
         settingsStorage: SettingsStorageService) {
        self.presenter = presenter
        self.flightWorker = flightWorker
        self.cityWorker = cityWorker
        self.airlineWorker = airlineWorker
        self.settingsStorage = settingsStorage
    }
    
    // MARK: - Network
    
    func loadData(request: FlightModels.Popular.Request) {
        guard let origin = originCity else {
            handleFailure(error: FlightBusinessLogicError.originCityNotSelected)
            return
        }
        let group = DispatchGroup()
        
        var flights: Result<[Flight], Error>?
        
        group.enter()
        flightWorker.loadPopularFlights(origin: origin.code, currency: settingsStorage.preferredCurrency) { result in
            flights = result
            group.leave()
        }
        
        var cities: Result<[City], Error>?
        
        group.enter()
        cityWorker.loadCities { result in
            cities = result
            group.leave()
        }
        
        var airlines: Result<[Airline], Error>?
        
        group.enter()
        airlineWorker.loadAirlines { result in
            airlines = result
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.process(origin: origin, flightsResult: flights, citiesResult: cities, airlinesResult: airlines)
        }
    }
    
    func selectFlight(request: FlightModels.SelectFlight.Request) {
        guard let selectedFlight = flights?[request.identifier] else {
            return
        }
        selectedDestinationCity = cities?[selectedFlight.destination]
    }
    
    private func process(origin: City,
                         flightsResult: Result<[Flight], Error>?,
                         citiesResult: Result<[City], Error>?,
                         airlinesResult: Result<[Airline], Error>?) {
        
        guard case let .success(flights) = flightsResult else {
            if case let .failure(error) = flightsResult {
                handleFailure(error: error)
            }
            return
        }
        guard case let .success(cities) = citiesResult else {
            if case let .failure(error) = flightsResult {
                handleFailure(error: error)
            }
            return
        }
        guard case let .success(airlines) = airlinesResult else {
            if case let .failure(error) = flightsResult {
                handleFailure(error: error)
            }
            return
        }
        let response = map(origin: origin, flights: flights, cities: cities, airlines: airlines)
        presenter.presentFlights(response: response)
    }
    
    func map(origin: City, flights: [Flight], cities: [City], airlines: [Airline]) -> FlightModels.Popular.Response {
        var citiesMap = [String: City]()
        cities.forEach { city in
            citiesMap[city.code] = city
        }
        self.cities = citiesMap
        
        // flightNumber is not unique, so we need to add local unique flight identifier.
        var flightsMap = [Int: Flight]()
        flights.enumerated().forEach {
            flightsMap[$0.offset] = $0.element
        }
        self.flights = flightsMap
        
        var airlinesMap = [String: Airline]()
        airlines.forEach { airline in
            airlinesMap[airline.code] = airline
        }
        
        return FlightModels.Popular.Response(
            flights: flights.enumerated().map { index, flight in
                FlightModels.Popular.Response.Item(
                    identifier: index,
                    origin: origin.name,
                    destination: citiesMap[flight.destination]?.name ?? flight.destination,
                    airlineName: airlinesMap[flight.airline]?.name ?? flight.airline,
                    airlineLogo: airlinesMap[flight.airline]?.logo,
                    departureDate: flight.departureDate,
                    returnDate: flight.returnDate,
                    price: flight.price,
                    transfers: flight.transfers
                )
            },
            currency: settingsStorage.preferredCurrency.currencySymbol
        )
    }
    
    private func handleFailure(error: Error) {
        flights = nil
        cities = nil
        airlines = nil
        let response = FlightModels.Failure.Response(error: error)
        presenter.presentFailure(response: response)
    }
}
