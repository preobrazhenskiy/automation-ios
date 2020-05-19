//
//  AirlineWorker.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/27/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

protocol AirlineWorker {
    func loadAirlines(completion: @escaping (Result<[Airline], Error>) -> Void)
}

final class AirlineWorkerImpl: AirlineWorker {

    private let client: NetworkClient

    private let logoBuilder: AirlineLogoBuilder
    
    init(client: NetworkClient, logoBuilder: AirlineLogoBuilder) {
        self.client = client
        self.logoBuilder = logoBuilder
    }
    
    func loadAirlines(completion: @escaping (Result<[Airline], Error>) -> Void) {
        let request = AirlinesRequest(token: AppConfig.TravelPayouts.apiToken)
        client.request(request) { (result: Result<[AirlineResponse], Error>) in
            switch result {
            case let .success(response):
                let airlines = response.map { Airline(code: $0.code, name: $0.name, logo: self.logoBuilder.logoURL(for: $0.code)) }
                completion(.success(airlines))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
