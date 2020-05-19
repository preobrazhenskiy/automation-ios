//
//  WeatherWorker.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/25/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import Foundation

protocol WeatherWorker {
    func loadWeather(city: String, completion: @escaping (Result<[Weather], Error>) -> Void)
}

final class WeatherWorkerImpl: WeatherWorker {
    
    private let client: NetworkClient
    
    private let iconBuilder: WeatherIconBuilder
    
    init(client: NetworkClient, iconBuilder: WeatherIconBuilder) {
        self.client = client
        self.iconBuilder = iconBuilder
    }
    
    func loadWeather(city: String, completion: @escaping (Result<[Weather], Error>) -> Void) {
        let request = WeatherRequest(city: city, appId: AppConfig.OpenWeather.appId)
        client.request(request) { (result: Result<WeatherResponse, Error>) in
            switch result {
            case let .success(response):
                let weather = response.list.map {
                    Weather(
                        wind: Weather.Wind(speed: $0.wind.speed, degree: $0.wind.degree),
                        clouds: Weather.Clouds(percentage: $0.clouds.all),
                        temperature: $0.main.temperature,
                        pressure: $0.main.pressure,
                        description: $0.weather.first?.description,
                        icon: $0.weather.first.flatMap { self.iconBuilder.iconURL(for: $0.icon) },
                        date: Date(timeIntervalSince1970: $0.date)
                    )
                }
                completion(.success(weather))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
