//
//  FlightWorkerMock.swift
//  WeatherAppTests
//
//  Created by Dmitry Pliushchai on 11/27/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

@testable import WeatherApp

class FlightWorkerMock: FlightWorker {
    
    func loadPopularFlights(origin: String, currency: Currency, completion: @escaping (Result<[Flight], Error>) -> Void) {
        
    }
}
