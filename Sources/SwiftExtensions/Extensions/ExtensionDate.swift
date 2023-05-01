//
//  ExtensionDate.swift
//  nhsios
//
//  Created by Amais Sheikh on 22/08/2022.
//

import Foundation

public extension Date
{
    var afterCurrentDate: Bool {
        return Date() < self
    }
    
    var oneDayAfter: Date {
        return  Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    var hundredYearsAgo: Date {
        return  Calendar.current.date(byAdding: .year, value: -100, to: self)!
    }
    
    func addMonth(n: Int) -> Date
    {
        let cal = NSCalendar.current
        return cal.date(byAdding: .month, value: n, to: self)!
    }
    
    func stringValue(format: String = "MM-dd-yyyy HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func stringValueFromUTC(format: String = "MM-dd-yyyy HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.string(from: self)
    }
}
