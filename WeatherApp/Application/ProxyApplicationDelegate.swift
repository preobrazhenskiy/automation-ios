//
//  ProxyApplicationDelegate.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/27/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import UIKit

class ProxyApplicationDelegate: UIResponder, UIApplicationDelegate {
    
    var delegates: [ApplicationDelegate] {
        return []
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        delegates.forEach { delegate in
            delegate.application(application, didFinishLaunchingWithOptions: launchOptions)
        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        delegates.forEach { delegate in
            delegate.applicationWillResignActive(application)
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        delegates.forEach { delegate in
            delegate.applicationWillTerminate(application)
        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        delegates.forEach { delegate in
            delegate.applicationWillEnterForeground(application)
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        delegates.forEach { delegate in
            delegate.applicationDidBecomeActive(application)
        }
    }
}
