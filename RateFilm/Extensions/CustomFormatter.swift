//
//  CustomDateFormatter.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 16.10.2023.
//

import Foundation

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
            if let month = Months(number: date.get(.month))?.rawValue {
                return "\(month) \(date.get(.year))"
            } else {
                return "\(date.get(.year))"
            }
        }
        
        return nil
    }
    
    enum Months: String {
        case january = "Январь"
        case february = "Февраль"
        case march = "Март"
        case april = "Апрель"
        case may = "Май"
        case june = "Июнь"
        case july = "Июль"
        case august = "Август"
        case september = "Сентябрь"
        case october = "Октябрь"
        case november = "Ноябрь"
        case december = "Декабрь"
        
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
    }
}
