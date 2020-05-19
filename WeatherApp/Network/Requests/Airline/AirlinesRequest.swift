//
//  AirlinesRequest.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/27/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

struct AirlinesRequest: NetworkRequest {
    
    let host = AppConfig.TravelPayouts.host
    
    let path = "/data/en/airlines.json"
    
    let method: HTTPMethod = .get
    
    let queryItems: HTTPQueryItems?
    
    init(token: String) {
        queryItems = [
            "token": token
        ]
    }
}
