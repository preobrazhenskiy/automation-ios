//
//  UserInterfaceSceneDelegate.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/27/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import UIKit

final class UserInterfaceApplicationDelegate: ApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        setupAppearance()
        setupFlow(application: application)
    }
    
    private func setupAppearance() {
        UIRefreshControl.appearance().tintColor = UIColor.mainRed
    }
    
    private func setupFlow(application: UIApplication) {
        guard let window = application.delegate?.window else {
            return
        }
        let containerViewController = ContainerAssembly.initializeFromStoryboard()
        
        // We don't have origin city picker, so let's assume that previously user choosed this city as origin.
        containerViewController.router?.dataStore?.originCity = City(name: "Tallinn", code: "TLL")
        
        let navigationController = UINavigationController(rootViewController: containerViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
