//
//  Storage.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/27/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

protocol Storage {
    func save(object: Any, forKey key: String)
    func object(forKey key: String) -> Any?
}
