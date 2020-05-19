//
//  UIView+Additions.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/26/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import UIKit

extension UIView {
    
    func fillToParent(left: CGFloat = 0, top: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) {
        guard let superview = superview else {
            return
        }
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: left),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -right),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: top),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottom)
        ])
    }
}
