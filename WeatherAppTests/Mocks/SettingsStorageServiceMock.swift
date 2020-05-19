//
//  SettingsStorageServiceMock.swift
//  WeatherAppTests
//
//  Created by Dmitry Pliushchai on 11/27/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

@testable import WeatherApp

class SettingsStorageServiceMock: SettingsStorageService {
    
    private let currency: Currency
    
    init(currency: Currency = .euro) {
        self.currency = currency
    }
    
    var preferredCurrency: Currency {
        return currency
    }
    
    func save(preferredCurrency: Currency) {
        
    }
}
