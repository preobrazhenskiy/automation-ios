//
//  WeatherRequest.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/25/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

struct WeatherRequest: NetworkRequest {
    
    let host = AppConfig.OpenWeather.host
    
    let path = "/data/2.5/forecast"
    
    let method: HTTPMethod = .get
    
    let queryItems: HTTPQueryItems?
    
    init(city: String, appId: String) {
        self.queryItems = [
            "q": city,
            "appid": appId
        ]
    }
}
