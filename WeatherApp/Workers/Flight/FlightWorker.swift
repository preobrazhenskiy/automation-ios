//
//  FlightWorker.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/26/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import Foundation

protocol FlightWorker {
    func loadPopularFlights(origin: String, currency: Currency, completion: @escaping (Result<[Flight], Error>) -> Void)
}

final class FlightWorkerImpl: FlightWorker {
    
    private let client: NetworkClient
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return formatter
    }()

    init(client: NetworkClient) {
        self.client = client
    }
    
    func loadPopularFlights(origin: String, currency: Currency, completion: @escaping (Result<[Flight], Error>) -> Void) {
        let request = PopularFlightsRequest(origin: origin, currency: currency.rawValue, token: AppConfig.TravelPayouts.apiToken)
        client.request(request) { (result: Result<PopularFlightsResponse, Error>) in
            switch result {
            case let .success(response):
                let flights = response.data.values.map {
                    Flight(
                        flightNumber: $0.flightNumber,
                        airline: $0.airline,
                        price: $0.price,
                        destination: $0.destination,
                        transfers: $0.transfers,
                        departureDate: self.formatter.date(from: $0.departureDate),
                        returnDate: self.formatter.date(from: $0.returnDate)
                    )
                }
                completion(.success(flights))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
