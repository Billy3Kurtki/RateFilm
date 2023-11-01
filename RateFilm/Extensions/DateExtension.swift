//
//  DateExtension.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 25.10.2023.
//

import SwiftUI

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
    
    static func formatDateToCustomString(unix: Int) -> String? {
        let date = unix.date
        let now = Date.now
        if date > now {
            if date.unixTimestamp > now.unixTimestamp + Consts.unixYear {
                return "\(date.get(.year))"
            } else {
                if let month = Months(number: date.get(.month))?.localizeString() {
                    return "\(month) \(date.get(.year))"
                }
            }
        }
        
        return nil
    }
    
    // MARK: Функция для определения категорий для сериала
    static func formatSeriesCountToString(seasons: [Season]) -> (String, [MainViewSelections]) {
        let now = Date.now.unixTimestamp
        let stringOf = LocalizedStrings.of.localizeString()
        let stringEp = LocalizedStrings.ep.localizeString()
        let stringAnnouncement = LocalizedStrings.announcement.localizeString()
        let unknownCount = "?"
        var selection: [MainViewSelections] = [.serials]
        
        if seasons.count > 0 {
            if let beforeExists = seasons.first(where: { $0.releaseDate < now }) {
                if let afterExits = seasons.first(where: { $0.releaseDate > now }) {
                    selection.append(.ongoings)
                    var realesedSeries = 0
                    var unRealesedSeries = 0
                    for i in seasons {
                        if i.releaseDate <= now {
                            realesedSeries += i.seriesCount
                        } else {
                            unRealesedSeries += i.seriesCount
                        }
                    }
                    let stringMaxCount = unRealesedSeries > 0 ? "\(realesedSeries + unRealesedSeries)" : unknownCount
                    return ("\(realesedSeries) \(stringOf) \(stringMaxCount) \(stringEp)", selection)
                }
                
                selection.append(.completed)
                var maxCount = 0
                for i in seasons {
                    maxCount += i.seriesCount
                }
                return ("\(maxCount) \(stringEp)", selection)
                
            } else if let afterExits = seasons.first(where: { $0.releaseDate > now }) {
                selection.append(.announcement)
                var maxCount = 0
                for i in seasons {
                    maxCount += i.seriesCount
                }
                let stringMaxCount = maxCount > 0 ? "\(maxCount)" : unknownCount
                return ("\(stringMaxCount) \(stringEp)", selection)
            }
        }
        selection.append(.announcement)
        return ("\(stringAnnouncement) \(unknownCount) \(stringEp)", selection)
    }
    
    enum LocalizedStrings: LocalizedStringKey {
        case of = "of"
        case ep = "ep"
        case announcement = "Announcement"
        
        func localizeString() -> String {
            return NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
        }
    }
    
    enum Consts {
        static var unixYear = 31556926
    }
    
    enum Months: LocalizedStringKey {
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
            return NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
        }
    }
}
