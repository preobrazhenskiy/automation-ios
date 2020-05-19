//
//  CellViewModel.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/26/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import UIKit

typealias AnyViewCell = UIView

protocol AnyCellViewModel {
    static var cellClass: AnyClass { get }
    static var uniqueIdentifier: String { get }
    func setup(cell: AnyViewCell)
}

extension AnyCellViewModel {
    static var uniqueIdentifier: String {
        return String(describing: self)
    }
}

protocol CellViewModel: AnyCellViewModel {
    associatedtype Cell: AnyViewCell
    func setup(cell: Cell)
}

extension CellViewModel {
    static var cellClass: AnyClass {
        return Cell.self
    }
    
    func setup(cell: AnyViewCell) {
        setup(cell: cell as! Cell)
    }
}
