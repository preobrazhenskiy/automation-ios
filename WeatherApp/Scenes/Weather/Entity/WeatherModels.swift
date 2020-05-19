import UIKit

enum WeatherModels {
    
    enum Forecast {
        struct Request {
        }
        
        struct Response {
            struct Forecast {
                let windSpeed: Double
                let windDegree: Int
                let cloudsPercentage: Int
                let temperature: Double
                let pressure: Int
                let description: String?
                let icon: URL?
                let date: Date
            }
            let forecasts: [Forecast]
            let cityName: String
        }
        
        struct ViewModel {
            struct Forecast {
                let windSpeed: String
                let windDegree: String
                let clouds: String
                let temperature: String
                let pressure: String
                let description: String?
                let icon: URL?
                let date: String
            }
            
            struct Section {
                let title: String
                let forecasts: [Forecast]
            }
            let sections: [Section]
            let title: String
        }
    }
    
    enum Failure {
        
        struct Response {
            let error: Error
        }
        
        struct ViewModel {
            let title: String?
            let errorMessage: String?
        }
    }
}
