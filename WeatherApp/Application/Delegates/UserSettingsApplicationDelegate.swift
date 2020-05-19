//
//  UserSettingsApplicationDelegate.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/27/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import UIKit

final class UserSettingsApplicationDelegate: ApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        setupSettingsStorage()
    }
    
    private func setupSettingsStorage() {
        let settingsStorage: SettingsStorageService = SettingsStorageServiceImpl(storage: UserDefaultsStorage())
        settingsStorage.save(preferredCurrency: .euro)
    }
}
