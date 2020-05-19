//
//  UIColor+Additions.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/26/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(rgb: Int, alpha: CGFloat = 1) {
        let r = (rgb >> 16) & 0xFF
        let g = (rgb >> 8) & 0xFF
        let b = (rgb >> 0) & 0xFF
        
        self.init(r: r, g: g, b: b, alpha: alpha)
    }
    
    convenience init(r: Int, g: Int, b: Int, alpha: CGFloat = 1) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
}

extension UIColor {
    static let background = UIColor(rgb: 0xf2f2f2)
    static let shadow = UIColor(rgb: 0xa4a4a4)
    static let mainRed = UIColor.red
}
