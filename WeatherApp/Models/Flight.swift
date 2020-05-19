//
//  Flight.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/26/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import Foundation

struct Flight {
    let flightNumber: Int
    let airline: String
    let price: Double
    let destination: String
    let transfers: Int
    let departureDate: Date?
    let returnDate: Date?
}
