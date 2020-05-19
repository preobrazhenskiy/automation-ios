//
//  NibInitializable.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/26/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import UIKit

protocol NibInitializable: AnyObject {
    static var nibFileName: String { get }
}

extension NibInitializable {
    
    static var nibFileName: String {
        return String(describing: self)
    }
}
