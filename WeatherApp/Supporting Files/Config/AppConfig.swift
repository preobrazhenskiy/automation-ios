//
//  AppConfig.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/27/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import Foundation

enum AppConfig {
    
    enum TravelPayouts {
        static let host = "https://api.travelpayouts.com"
        static let apiToken = Bundle.main.travelPayoutsAppId
    }
    
    enum OpenWeather {
        static let host = "https://api.openweathermap.org"
        static let appId = Bundle.main.openWeatherAppId
    }
}
