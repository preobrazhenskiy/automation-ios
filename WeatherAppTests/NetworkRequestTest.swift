//
//  NetworkRequestTest.swift
//  WeatherAppTests
//
//  Created by Dmitry Pliushchai on 11/27/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import XCTest
@testable import WeatherApp

final class NetworkRequestTest: XCTestCase {
    
    private var sut: NetworkRequestMock!
    
    override func setUp() {
        super.setUp()
        sut = NetworkRequestMock()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testDefaultContentTypeApplicationJSON() {
        do {
            let request = try sut.asURLRequest()
            XCTAssertEqual(request.allHTTPHeaderFields?["Content-Type"], "application/json")
        } catch {
            XCTFail("URLRequest construction failed: \(error)")
        }
    }
    
    func testHeadersEqual() {
        let headers = ["1": "a", "2": "b"]
        sut.headers = headers
        
        do {
            let request = try sut.asURLRequest()
            XCTAssertEqual(request.allHTTPHeaderFields, headers.merging(["Content-Type": "application/json"], uniquingKeysWith: { lhs, _ in lhs }))
        } catch {
            XCTFail("URLRequest construction failed: \(error)")
        }
    }
    
    func testHttpBodyEqual() {
        let body: [String: Any] = ["1": 1, "2": "b"]
        sut.params = body
        
        do {
            let request = try sut.asURLRequest()
            let requestBody = request.httpBody
            let requestBodyObject = try JSONSerialization.jsonObject(with: requestBody!) as! NSDictionary
            
            XCTAssertEqual(requestBodyObject, body as NSDictionary)
        } catch {
            XCTFail("URLRequest construction failed: \(error)")
        }
    }
    
    func testHttpMethodEqual() {
        sut.method = .patch
        
        do {
            let request = try sut.asURLRequest()
            XCTAssertEqual(request.httpMethod, "PATCH")
        } catch {
            XCTFail("URLRequest construction failed: \(error)")
        }
    }
    
    func testQueryItemsEqual() {
        let query = ["123": "abc", "345": "cde"]
        sut.queryItems = query
        
        do {
            let request = try sut.asURLRequest()
            let urlComponents = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)
            let queryItems = urlComponents?.queryItems?.reduce(into: [String: String]()) { $0[$1.name] = $1.value }
            XCTAssertEqual(query, queryItems)
        } catch {
            XCTFail("URLRequest construction failed: \(error)")
        }
    }
}
