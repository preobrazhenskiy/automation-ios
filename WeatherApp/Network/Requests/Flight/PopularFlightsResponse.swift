//
//  PopularFlightsResponse.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/26/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

struct PopularFlightsResponse: Decodable {
    struct Flight: Decodable {
        let origin: String
        let destination: String
        let price: Double
        let transfers: Int
        let airline: String
        let flightNumber: Int
        let departureDate: String
        let returnDate: String
        let expiryDate: String
        
        enum CodingKeys: String, CodingKey {
            case origin
            case destination
            case price
            case transfers
            case airline
            case flightNumber   = "flight_number"
            case departureDate  = "departure_at"
            case returnDate     = "return_at"
            case expiryDate     = "expires_at"
        }
    }
    
    let data: [String: Flight]
}
