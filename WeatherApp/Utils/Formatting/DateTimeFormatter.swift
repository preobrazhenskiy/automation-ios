//
//  DateTimeFormatter.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/27/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import Foundation

final class DateTimeFormatter {
    
    private let formatter = DateFormatter()
    
    func fullString(from date: Date) -> String {
        formatter.dateFormat = "d MMM yyyy HH:mm"
        return formatter.string(from: date)
    }
    
    func dayString(from date: Date) -> String {
        formatter.dateFormat = "d MMMM"
        return formatter.string(from: date)
    }
    
    func timeString(from date: Date) -> String {
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
