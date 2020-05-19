//
//  AirlineWorkerMock.swift
//  WeatherAppTests
//
//  Created by Dmitry Pliushchai on 11/27/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

@testable import WeatherApp

class AirlineWorkerMock: AirlineWorker {
    
    func loadAirlines(completion: @escaping (Result<[Airline], Error>) -> Void) {
        
    }
}
