//
//  WeatherCellViewModel.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/26/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import Foundation

protocol WeatherCellViewModelData {
    var windSpeed: String { get }
    var windDegree: String { get }
    var clouds: String { get }
    var temperature: String { get }
    var pressure: String { get }
    var description: String? { get }
    var icon: URL? { get }
    var date: String { get }
}

final class WeatherCellViewModel: CellViewModel, WeatherCellViewModelData {
    
    let windSpeed: String
    let windDegree: String
    let clouds: String
    let temperature: String
    let pressure: String
    let description: String?
    let icon: URL?
    let date: String
    
    init(windSpeed: String,
         windDegree: String,
         clouds: String,
         temperature: String,
         pressure: String,
         description: String?,
         icon: URL?,
         date: String) {
        self.windSpeed = windSpeed
        self.windDegree = windDegree
        self.clouds = clouds
        self.temperature = temperature
        self.description = description
        self.pressure = pressure
        self.icon = icon
        self.date = date
    }
    
    func setup(cell: WeatherTableViewCell) {
        cell.setup(with: self)
    }
}
