//
//  NetworkRequest.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/25/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import Foundation

enum NetworkRequestError: Error {
    case invalidURL
}

protocol NetworkRequest: URLRequestConvertible {
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var params: HTTPParameters? { get }
    var headers: HTTPHeaders { get }
    var queryItems: HTTPQueryItems? { get }
}

extension NetworkRequest {
    
    var queryItems: HTTPQueryItems? {
        return [:]
    }
    
    var params: HTTPParameters? {
        return nil
    }
    
    var headers: HTTPHeaders {
        return [:]
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try makeURL()
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try params.map { try JSONSerialization.data(withJSONObject: $0) }
        request.httpMethod = method.rawValue
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
    
    private func makeURL() throws -> URL {
        var urlComponents = URLComponents(string: "\(host)\(path)")
        if let queryItems = queryItems, !queryItems.isEmpty {
            urlComponents?.queryItems = queryItems.map { URLQueryItem(name: $0, value: $1) }
        }
        guard let url = urlComponents?.url else {
            throw NetworkRequestError.invalidURL
        }
        return url
    }
}
