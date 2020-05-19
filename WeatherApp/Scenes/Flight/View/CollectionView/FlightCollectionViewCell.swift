//
//  FlightCollectionViewCell.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/26/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import UIKit
import Kingfisher

final class FlightCollectionViewCell: UICollectionViewCell, NibInitializable {

    // MARK: - Views
    
    @IBOutlet private var originLabel: UILabel!
    
    @IBOutlet private var destinationLabel: UILabel!
    
    @IBOutlet private var airlineImageView: UIImageView!
    
    @IBOutlet private var departureLabel: UILabel!
    
    @IBOutlet private var returnLabel: UILabel!
    
    @IBOutlet private var priceLabel: UILabel!
    
    @IBOutlet private var transfersLabel: UILabel!
    
    // MARK: - Setup
    
    func setup(with viewModel: FlightCellViewModelData) {
        originLabel.text = viewModel.origin
        destinationLabel.text = viewModel.destination
        airlineImageView.kf.setImage(with: viewModel.airlineLogo)
        priceLabel.text = viewModel.price
        departureLabel.text = viewModel.departureDate
        returnLabel.text = viewModel.returnDate
        transfersLabel.text = viewModel.transfers
    }
}
