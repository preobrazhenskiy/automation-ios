//
//  Weather.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/25/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import Foundation

struct Weather {
    struct Wind {
        let speed: Double
        let degree: Int
    }
    struct Clouds {
        let percentage: Int
    }
    let wind: Wind
    let clouds: Clouds
    let temperature: Double
    let pressure: Int
    let description: String?
    let icon: URL?
    let date: Date
}
