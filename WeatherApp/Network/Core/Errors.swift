//
//  Errors.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/25/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

enum NetworkError: Error {
    case invalidURLRequest
    case jsonDecodingError(Error)
}
