//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/25/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: ProxyApplicationDelegate {

    var window: UIWindow? = UIWindow()
    
    private let _delegates: [ApplicationDelegate] = [
        UserSettingsApplicationDelegate(),
        UserInterfaceApplicationDelegate()
    ]
    
    override var delegates: [ApplicationDelegate] {
        return _delegates
    }
}
