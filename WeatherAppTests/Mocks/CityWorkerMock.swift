//
//  CityWorkerMock.swift
//  WeatherAppTests
//
//  Created by Dmitry Pliushchai on 11/27/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

@testable import WeatherApp

class CityWorkerMock: CityWorker {
    
    func loadCities(completion: @escaping (Result<[City], Error>) -> Void) {
        
    }
}
