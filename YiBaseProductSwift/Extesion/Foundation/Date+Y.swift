
//
//  Date+Y.swift
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/9/15.
//  Copyright © 2020 任斌. All rights reserved.
//

import Foundation

extension Date {
    static private let _formatter1 = DateFormatter()
    static private let _formatter2 = DateFormatter()
    
    public static func y_timeToChinaTimeString(time: Date = Date(),
                                               formatter: String = "YYYY-MM-dd HH:mm") -> String? {
        guard let chinaTimeZone  = TimeZone(secondsFromGMT: 8 * 3600) else {
            return nil
        }
        _formatter1.timeZone = chinaTimeZone
        _formatter1.dateFormat = formatter
        return _formatter1.string(from: time)
    }
    
    public static func y_stringToString(timeString: String,
                                        fromTimeZone: Int,
                                        toTimeZone: Int,
                                        fromFormatter: String,
                                        toFormatter: String) -> String? {
        guard let fromTZ = TimeZone(secondsFromGMT: fromTimeZone * 3600), let toTZ = TimeZone(secondsFromGMT: toTimeZone * 3600) else {
            return nil
        }
        _formatter1.timeZone = fromTZ
        _formatter2.timeZone = toTZ
        _formatter1.dateFormat = fromFormatter
        _formatter2.dateFormat = toFormatter
        guard let date = _formatter1.date(from: timeString) else {
            return nil
        }
        return _formatter2.string(from: date)
    }
    
    public static func y_dateFromString(timeString: String,
                                        formatter: String,
                                        timeZone: Int = 8) -> Date? {
        guard let tz = TimeZone(secondsFromGMT: timeZone * 3600) else {
            return nil
        }
        _formatter1.dateFormat = formatter
        _formatter1.timeZone   = tz
        return _formatter1.date(from: timeString)
    }
    
    public func y_days() -> [Int] {
        let calendar = Calendar.current
        var result   = [Int]()
        if let days = calendar.range(of: .day, in: .month, for: self) {
            result = Array(days)
        }
        return result
    }
    
    public func y_daysCount() -> Int {
        return y_days().count
    }
    
    /// be careful: thr first day of week is sunday
    public func y_dayOfWeek() -> Int? {
        return Calendar.current.ordinality(of: .day, in: .weekOfMonth, for: self)
    }
    
    public func y_weekOfMonth() -> Int? {
        return Calendar.current.ordinality(of: .weekOfMonth, in: .month, for: self)
    }
    
    public func y_weekOfYear() -> Int? {
        return Calendar.current.ordinality(of: .weekOfYear, in: .year, for: self)
    }
}
