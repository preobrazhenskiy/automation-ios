//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/25/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

struct WeatherResponse: Decodable {
    
    struct Forecast: Decodable {
        
        struct Main: Decodable {
            let temperature: Double
            let minTemperature: Double
            let maxTemperature: Double
            let pressure: Int
            let seaLevel: Int
            let grandLevel: Int
            let humidity: Int
            let temperatureCoefficient: Double
            
            enum CodingKeys: String, CodingKey {
                case temperature    = "temp"
                case minTemperature = "temp_min"
                case maxTemperature = "temp_max"
                case pressure
                case seaLevel       = "sea_level"
                case grandLevel     = "grnd_level"
                case humidity
                case temperatureCoefficient = "temp_kf"
            }
        }
        
        struct Weather: Decodable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }
        
        struct Wind: Decodable {
            let speed: Double
            let degree: Int
            
            enum CodingKeys: String, CodingKey {
                case speed
                case degree = "deg"
            }
        }
        struct Clouds: Decodable {
            let all: Int
        }
        
        enum CodingKeys: String, CodingKey {
            case wind
            case clouds
            case main
            case weather
            case date = "dt"
        }
        
        let wind: Wind
        let clouds: Clouds
        let main: Main
        let weather: [Weather]
        let date: Double
    }
    
    let list: [Forecast]
}
