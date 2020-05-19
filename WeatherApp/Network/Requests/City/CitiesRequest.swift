//
//  CitiesRequest.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/25/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

struct CitiesRequest: NetworkRequest {
    
    let host = AppConfig.TravelPayouts.host
    
    let path = "/data/en/cities.json"
    
    let method: HTTPMethod = .get
    
    let queryItems: HTTPQueryItems?
    
    init(token: String) {
        queryItems = [
            "token": token
        ]
    }
}
