//
//  DateExtension.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 25.10.2023.
//

import Foundation

extension Date {
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

typealias UnixTimestamp = Int

extension Date {
    var unixTimestamp: UnixTimestamp {
        return UnixTimestamp(self.timeIntervalSince1970 * 1_000)
    }
}

extension UnixTimestamp {
    var date: Date {
        return Date(timeIntervalSince1970: TimeInterval((self + 10800000) / 1_000))
    }
}

class CustomFormatter {
    static func formatFloat(float: Float) -> String {
        return String(format: "%.1f", float)
    }
    
    static func formatAvgRating(float: Float) -> Float {
        if float < 0.0 {
            return 0.0
        } else if float > 5.0 {
            return 5.0
        } else {
            return float
        }
    }
    
    static func formatDateToCustomString(date: Int) -> String? {
        let date = date.date
        if date > Date.now {
            if let month = Months(number: date.get(.month))?.localizeString() {
                return "\(month) \(date.get(.year))"
            } else {
                return "\(date.get(.year))"
            }
        }
        
        return nil
    }
    
    enum Months: String {
        case january = "january"
        case february = "february"
        case march = "march"
        case april = "april"
        case may = "may"
        case june = "june"
        case july = "july"
        case august = "august"
        case september = "september"
        case october = "october"
        case november = "november"
        case december = "december"
        
        init?(number: Int) {
            switch number {
            case 1: self = .january
            case 2: self = .february
            case 3: self = .march
            case 4: self = .april
            case 5: self = .may
            case 6: self = .june
            case 7: self = .july
            case 8: self = .august
            case 9: self = .september
            case 10: self = .october
            case 11: self = .november
            case 12: self = .december
            default: return nil
            }
        }
        
        func localizeString() -> String {
            return NSLocalizedString(self.rawValue, comment: "")
        }
    }
}
