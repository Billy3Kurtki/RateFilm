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
     
    static func formatSeriesCountToString(countSeriesLeft: Int, countSeriesMax: Int?) -> String {
        let stringOf = LocalizedStrings.of.localizeString()
        let stringEp = LocalizedStrings.ep.localizeString()
        let stringAnnouncement = LocalizedStrings.announcement.localizeString()
        let unknownCount = "?"
        
        if let countSeriesMax = countSeriesMax {
            if countSeriesLeft > 0 {
                if countSeriesMax == countSeriesLeft {
                    return "\(countSeriesLeft) \(stringEp)"
                }
                return "\(countSeriesLeft) \(stringOf) \(countSeriesMax) \(stringEp)"
            }
            return "\(stringAnnouncement) \(unknownCount) \(stringEp)"
        } else {
            if countSeriesLeft > 0 {
                return "\(countSeriesLeft) \(stringEp)"
            }
            return "\(stringAnnouncement) \(unknownCount) \(stringEp)"
        }
    }
    
    static func convertStringToMovieStatus(_ status: String) -> MovieStatus {
        guard let movieStatus = MovieStatus.allCases.first(where: { "\($0)".lowercased() == status.lowercased() })
        else {
            return .none
        }
        return movieStatus
    }
    
    static func convertStringToGenre(_ genre: String) -> Genre? {
        Genre.allCases.first(where: { "\($0)".lowercased() == genre.lowercased() })
    }
    
    static func convertStringToProfession(_ profession: String) -> Profession? {
        Profession.allCases.first(where: { "\($0)".lowercased() == profession.lowercased() })
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
