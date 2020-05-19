//
//  FlightRequest.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/26/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

struct PopularFlightsRequest: NetworkRequest {
    
    let host = AppConfig.TravelPayouts.host
    
    let path = "/v1/city-directions"
    
    let method: HTTPMethod = .get
    
    let queryItems: HTTPQueryItems?
    
    init(origin: String, currency: String, token: String) {
        queryItems = [
            "origin": origin,
            "currency": currency,
            "token": token
        ]
    }
}
