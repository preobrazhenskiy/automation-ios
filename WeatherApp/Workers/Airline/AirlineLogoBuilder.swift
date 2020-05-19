//
//  AirlineLogoBuilder.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/27/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import Foundation

protocol AirlineLogoBuilder {
    func logoURL(for iataCode: String) -> URL?
    func logoURL(for iataCode: String, width: Int, height: Int) -> URL?
}

/// More details: https://support.travelpayouts.com/hc/en-us/articles/203956163#logo
final class AirlineLogoBuilderImpl: AirlineLogoBuilder {
    
    private let defaultWidth: Int = 160
    
    private let defaultHeight: Int = 128
    
    func logoURL(for iataCode: String) -> URL? {
        return logoURL(for: iataCode, width: defaultWidth, height: defaultHeight)
    }
    
    func logoURL(for iataCode: String, width: Int, height: Int) -> URL? {
        return URL(string: "https://pics.avs.io/\(width)/\(height)/\(iataCode).png")
    }
}
