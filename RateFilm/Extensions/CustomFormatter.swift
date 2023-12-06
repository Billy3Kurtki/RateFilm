//
//  CustomFormatter.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 04.11.2023.
//

import SwiftUI

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
        let date = unix
        let now = Date.now.unixTimestamp
        if date > now {
            if date > now + UnixConsts.unixYear {
                return "\(date.date.get(.year))"
            } else {
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale.current
                dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
                return "\(dateFormatter.string(from: date.date)) \(date.date.get(.year))"
            }
        }
        
        return nil
    }
    
    //допилить
    // MARK: Функция для определения категорий сериала
    static func formatSeriesCountToString(seasons: [Season]) -> (String, [MainViewSelections]) {
        let now = Date.now.unixTimestamp
        let stringOf = LocalizedStrings.of.localizeString()
        let stringEp = LocalizedStrings.ep.localizeString()
        let stringAnnouncement = LocalizedStrings.announcement.localizeString()
        let unknownCount = "?"
        var selection: [MainViewSelections] = []
        let startDate: Int = now - 2 * UnixConsts.unixMonth
        let endDate: Int = now
        let range = startDate...endDate
        
        if seasons.count > 0 {
            if let _ = seasons.first(where: { $0.releaseDate < now }) {
                if let _ = seasons.first(where: { $0.releaseDate > now }) {
                    selection.append(.ongoings)
                    var realesedSeries = 0
                    var unRealesedSeries = 0
                    for i in seasons {
                        if i.releaseDate <= now {
                            realesedSeries += i.series.count
                        } else {
                            unRealesedSeries += i.series.count
                        }
                    }
                    let stringMaxCount = unRealesedSeries > 0 ? "\(realesedSeries + unRealesedSeries)" : unknownCount
                    
                    if let _ = seasons.first(where: { range.contains($0.releaseDate) }) { // если что-то вышло за последние 2 месяца
                        selection.append(.lastReleased)
                    }
                    return ("\(realesedSeries) \(stringOf) \(stringMaxCount) \(stringEp)", selection)
                }
                
                selection.append(.completed)
                var maxCount = 0
                for i in seasons {
                    maxCount += i.series.count
                }
                if let _ = seasons.first(where: { range.contains($0.releaseDate)  }) {
                    selection.append(.lastReleased)
                }
                return ("\(maxCount) \(stringEp)", selection)
                
            } else if let _ = seasons.first(where: { $0.releaseDate > now }) {
                selection.append(.announcement)
                var maxCount = 0
                for i in seasons {
                    maxCount += i.series.count
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
}

enum UnixConsts {
    static var unixYear = 31556926000
    static var unixMonth = 2629743000
}
