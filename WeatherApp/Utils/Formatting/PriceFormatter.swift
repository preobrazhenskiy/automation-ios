//
//  PriceFormatter.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/27/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import Foundation

final class PriceFormatter {
    
    private let numberFormatter: NumberFormatter = {
        let groupingFormat = "###,###,###,###.##"
        
        let formatter = NumberFormatter()
        formatter.formatterBehavior = .default
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.positiveFormat = "¤\(groupingFormat)"
        formatter.negativeFormat = "-¤\(groupingFormat)"
        formatter.currencyGroupingSeparator = ","
        formatter.currencyDecimalSeparator = "."
        return formatter
    }()
    
    func string(for value: Double, currency: String) -> String? {
        numberFormatter.currencySymbol = currency
        return numberFormatter.string(for: value)
    }
}
