//
//  FlightInteractorTest.swift
//  WeatherAppTests
//
//  Created by Dmitry Pliushchai on 11/27/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import XCTest
@testable import WeatherApp

final class FlightInteractorTest: XCTestCase {
    
    private var sut: FlightInteractor!

    override func setUp() {
        super.setUp()
        sut = FlightInteractor(
            presenter: FlightPresenterMock(),
            flightWorker: FlightWorkerMock(),
            cityWorker: CityWorkerMock(),
            airlineWorker: AirlineWorkerMock(),
            settingsStorage: SettingsStorageServiceMock()
        )
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testObjectsMapping() {
        let airlineName = "Ryanair"
        let origin = "Tallinn"
        let destination = "Berlin"
        
        let city = City(name: origin, code: "TLL")
        
        let response = sut.map(
            origin: city,
            flights: [
                Flight(flightNumber: 1, airline: "RN", price: 1, destination: "BER", transfers: 1, departureDate: nil, returnDate: nil)
            ],
            cities: [City(name: "Test", code: "TT"), City(name: destination, code: "BER")],
            airlines: [Airline(code: "RN", name: airlineName, logo: nil)]
        )
        
        XCTAssertEqual(response.flights[0].airlineName, airlineName)
        XCTAssertEqual(response.flights[0].destination, destination)
        XCTAssertEqual(response.flights[0].origin, origin)
    }
    
    func testCurrencyMapping() {
        let preferredCurrency = Currency.usd
        
        let sut = FlightInteractor(
            presenter: FlightPresenterMock(),
            flightWorker: FlightWorkerMock(),
            cityWorker: CityWorkerMock(),
            airlineWorker: AirlineWorkerMock(),
            settingsStorage: SettingsStorageServiceMock(currency: preferredCurrency)
        )
        
        let response = sut.map(
            origin: City(name: "Test", code: "TT"),
            flights: [],
            cities: [],
            airlines: []
        )
        
        XCTAssertEqual(response.currency, preferredCurrency.currencySymbol)
    }
}
