//
//  NetworkRequestMock.swift
//  WeatherAppTests
//
//  Created by Dmitry Pliushchai on 11/27/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

@testable import WeatherApp

// Logic of URLRequest construction is places in protocol extension, so we need to just conform mock to the protocol and test using mock object.
class NetworkRequestMock: NetworkRequest {
    var host: String = "https://example.com"
    var path: String = "/path"
    var method: HTTPMethod = .get
    var headers: HTTPHeaders = [:]
    var queryItems: HTTPQueryItems? = [:]
    var params: HTTPParameters? = [:]
}
