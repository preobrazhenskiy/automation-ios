//
//  Bundle+AppConfig.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/27/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import Foundation

extension Bundle {
    
    var openWeatherAppId: String {
        return object(forInfoDictionaryKey: "APP_ID_OPEN_WEATHER") as! String
    }
    
    var travelPayoutsAppId: String {
        return object(forInfoDictionaryKey: "APP_ID_TRAVEL_PAYOUTS") as! String
    }
}
