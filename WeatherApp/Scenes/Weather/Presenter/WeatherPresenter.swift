import UIKit

protocol WeatherPresentationLogic {
    func presentForecast(response: WeatherModels.Forecast.Response)
    func presentFailure(response: WeatherModels.Failure.Response)
    func presentLoading()
}

final class WeatherPresenter: WeatherPresentationLogic {
    
    weak var viewController: WeatherDisplayLogic?
    
    private let dateFormatter = DateTimeFormatter()
    
    // MARK: - Weather Presentation
    
    func presentForecast(response: WeatherModels.Forecast.Response) {
        var sections = [WeatherModels.Forecast.ViewModel.Section]()
        
        if var currentDay = response.forecasts.first?.date {
            var currentForecasts = [WeatherModels.Forecast.ViewModel.Forecast]()
            
            for forecast in response.forecasts {
                defer { currentDay = forecast.date }
                
                let forecastViewModel = WeatherModels.Forecast.ViewModel.Forecast(
                    windSpeed: "\(forecast.windSpeed) m/s",
                    windDegree: "\(forecast.windDegree) °",
                    clouds: "\(forecast.cloudsPercentage) %",
                    temperature: "\(forecast.temperature) F",
                    pressure: "\(forecast.pressure)",
                    description: forecast.description.flatMap { $0.capitalized },
                    icon: forecast.icon,
                    date: dateFormatter.timeString(from: forecast.date)
                )
                
                if !Calendar.current.isDate(currentDay, inSameDayAs: forecast.date) {
                    sections.append(WeatherModels.Forecast.ViewModel.Section(title: dateFormatter.dayString(from: currentDay), forecasts: currentForecasts))
                    currentForecasts.removeAll()
                }
                currentForecasts.append(forecastViewModel)
            }
            
            sections.append(WeatherModels.Forecast.ViewModel.Section(title: dateFormatter.dayString(from: currentDay), forecasts: currentForecasts))
        }
        
        let viewModel = WeatherModels.Forecast.ViewModel(
            sections: sections,
            title: "Weather in \(response.cityName)"
        )
        viewController?.displayForecast(viewModel: viewModel)
    }
    
    func presentFailure(response: WeatherModels.Failure.Response) {
        let errorMessage: String?
        switch response.error {
        case let error as WeatherBusinessLogicError where error == .cityNotSelected:
            errorMessage = nil
        default:
            errorMessage = "Something went wrong, please try again later ..."
        }
        let viewModel = WeatherModels.Failure.ViewModel(title: nil, errorMessage: errorMessage)
        viewController?.displayFailure(response: viewModel)
    }
    
    func presentLoading() {
        viewController?.displayLoading()
    }
}
