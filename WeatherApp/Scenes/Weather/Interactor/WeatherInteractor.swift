import UIKit

protocol WeatherBusinessLogic {
    func loadForecast(request: WeatherModels.Forecast.Request)
}

protocol WeatherDataStore {
    var city: City? { get set }
}

enum WeatherBusinessLogicError: Error {
    case cityNotSelected
}

final class WeatherInteractor: WeatherBusinessLogic, WeatherDataStore, FlightDelegate {
    
    private let presenter: WeatherPresentationLogic
    
    private let weatherWorker: WeatherWorker
    
    // MARK: - Data Store
    
    var city: City?
    
    // MARK: - Init
    
    init(presenter: WeatherPresentationLogic, weatherWorker: WeatherWorker) {
        self.presenter = presenter
        self.weatherWorker = weatherWorker
    }
    
    // MARK: - Network
    
    func loadForecast(request: WeatherModels.Forecast.Request) {
        guard let city = city else {
            handleFailure(error: WeatherBusinessLogicError.cityNotSelected)
            return
        }
        loadForecast(for: city)
    }
    
    private func loadForecast(for city: City) {
        presenter.presentLoading()
        
        weatherWorker.loadWeather(city: city.name) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(weather):
                let response = self.map(weather: weather, city: city)
                self.presenter.presentForecast(response: response)
                
            case let .failure(error):
                self.handleFailure(error: error)
            }
        }
    }
    
    private func map(weather: [Weather], city: City) -> WeatherModels.Forecast.Response {
        return WeatherModels.Forecast.Response(forecasts: weather.map {
            WeatherModels.Forecast.Response.Forecast(
                windSpeed: $0.wind.speed,
                windDegree: $0.wind.degree,
                cloudsPercentage: $0.clouds.percentage,
                temperature: $0.temperature,
                pressure: $0.pressure,
                description: $0.description,
                icon: $0.icon,
                date: $0.date
            )
        }, cityName: city.name)
    }
    
    private func handleFailure(error: Error) {
        let response = WeatherModels.Failure.Response(error: error)
        presenter.presentFailure(response: response)
    }
    
    func showWeather(for city: City) {
        self.city = city
        loadForecast(for: city)
    }
}
