//
//  SettingsStorage.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/27/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

protocol SettingsStorageService {
    
    var preferredCurrency: Currency { get }
    
    func save(preferredCurrency: Currency)
}

final class SettingsStorageServiceImpl: SettingsStorageService {
    
    private enum Keys {
        static let preferredCurrency = "kPreferredCurrency"
        static let preferredCurrencySymbol = "kPreferredCurrencySymbol"
    }
    
    private let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    var preferredCurrency: Currency {
        return (storage.object(forKey: Keys.preferredCurrency) as? String).flatMap { Currency(rawValue: $0) } ?? .euro
    }
    
    func save(preferredCurrency: Currency) {
        storage.save(object: preferredCurrency.rawValue, forKey: Keys.preferredCurrency)
    }
}
