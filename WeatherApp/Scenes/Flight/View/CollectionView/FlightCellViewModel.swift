//
//  FlightCellViewModel.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/26/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import Foundation

protocol FlightCellViewModelData {
    var identifier: Int { get }
    var origin: String { get }
    var destination: String { get }
    var airlineName: String { get }
    var airlineLogo: URL? { get }
    var departureDate: String? { get }
    var returnDate: String? { get }
    var price: String? { get }
    var transfers: String { get }
}

final class FlightCellViewModel: CellViewModel, FlightCellViewModelData {
    
    let identifier: Int
    let origin: String
    let destination: String
    let airlineName: String
    let airlineLogo: URL?
    let departureDate: String?
    let returnDate: String?
    let price: String?
    let transfers: String
    
    init(identifier: Int,
         origin: String,
         destination: String,
         airlineName: String,
         airlineLogo: URL?,
         departureDate: String?,
         returnDate: String?,
         price: String?,
         transfers: String) {
        self.identifier = identifier
        self.origin = origin
        self.destination = destination
        self.airlineName = airlineName
        self.airlineLogo = airlineLogo
        self.departureDate = departureDate
        self.returnDate = returnDate
        self.price = price
        self.transfers = transfers
    }
    
    func setup(cell: FlightCollectionViewCell) {
        cell.setup(with: self)
    }
}
