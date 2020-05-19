//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/26/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import UIKit
import Kingfisher

final class WeatherTableViewCell: UITableViewCell, NibInitializable {

    // MARK: - Views
    
    @IBOutlet private var temperatureLabel: UILabel!
    
    @IBOutlet private var iconImageView: UIImageView!
    
    @IBOutlet private var descriptionLabel: UILabel!
    
    @IBOutlet private var windLabel: UILabel!
    
    @IBOutlet private var cloudsLabel: UILabel!
    
    @IBOutlet private var pressureLabel: UILabel!
    
    @IBOutlet private var dateTimeLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    // MARK: - Setup
    
    func setup(with viewModel: WeatherCellViewModelData) {
        temperatureLabel.text = viewModel.temperature
        iconImageView.kf.setImage(with: viewModel.icon)
        descriptionLabel.text = viewModel.description
        windLabel.text = "Wind: \(viewModel.windSpeed), \(viewModel.windDegree)"
        cloudsLabel.text = "Clouds: \(viewModel.clouds)"
        pressureLabel.text = "Pressure: \(viewModel.pressure)"
        dateTimeLabel.text = viewModel.date
    }
}
