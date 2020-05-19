//
//  WeatherIconBuilder.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/27/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import Foundation

protocol WeatherIconBuilder {
    func iconURL(for code: String) -> URL?
}

/// More details: https://openweathermap.org/weather-conditions
final class WeatherIconBuilderImpl: WeatherIconBuilder {
    
    func iconURL(for code: String) -> URL? {
        return URL(string: "https://openweathermap.org/img/wn/\(code)@2x.png")
    }
}
