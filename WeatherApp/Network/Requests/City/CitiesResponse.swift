//
//  CitiesResponse.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/25/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

struct CityResponse: Decodable {
    
    struct Coordinates: Decodable {
        let latitude: Double
        let longitude: Double
        
        enum CodingKeys: String, CodingKey {
            case latitude   = "lat"
            case longitude  = "lon"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case code
        case countryCode    = "country_code"
        case timeZone       = "time_zone"
        case coordinates
    }
    
    let name: String
    let code: String
    let countryCode: String
    let timeZone: String
    let coordinates: Coordinates?
}
