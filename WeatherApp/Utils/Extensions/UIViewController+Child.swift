//
//  UIViewController+Child.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/26/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showContentViewController(_ contentViewController: UIViewController, in containerView: UIView? = nil) {
        let containerView = containerView ?? self.view
        addChild(contentViewController)
        containerView?.addSubview(contentViewController.view)
        contentViewController.view?.translatesAutoresizingMaskIntoConstraints = false
        contentViewController.view?.fillToParent()
        contentViewController.didMove(toParent: self)
    }
    
    func hideContentViewController(content: UIViewController) {
        content.willMove(toParent: nil)
        content.view.removeFromSuperview()
        content.removeFromParent()
    }
}
