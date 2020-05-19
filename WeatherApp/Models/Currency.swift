//
//  Currency.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/27/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import Foundation

enum Currency: String {
    case euro   = "EUR"
    case usd    = "USD"
    
    var currencySymbol: String {
        switch self {
        case .euro:
            return "€"
        case .usd:
            return "$"
        }
    }
}
