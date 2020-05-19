//
//  CityWorker.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/25/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

protocol CityWorker {
    func loadCities(completion: @escaping (Result<[City], Error>) -> Void)
}

final class CityWorkerImpl: CityWorker {

    private let client: NetworkClient

    init(client: NetworkClient) {
        self.client = client
    }
    
    func loadCities(completion: @escaping (Result<[City], Error>) -> Void) {
        let request = CitiesRequest(token: AppConfig.TravelPayouts.apiToken)
        client.request(request) { (result: Result<[CityResponse], Error>) in
            switch result {
            case let .success(response):
                let cities = response.map { City(name: $0.name, code: $0.code) }
                completion(.success(cities))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
