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
    
    static func convertStatusOfPeople(_ statusOfPeople: [String : Int]?) -> [MovieStatus : Int] {
        var dict: [MovieStatus : Int] = [:]
        for i in MovieStatus.allCases {
            if i != .none {
                dict[i] = 0
            }
        }
        
        if let newDict = statusOfPeople {
            var tempDict: [MovieStatus : Int] = [:]
            for i in newDict {
                let tempStatus = convertStringToMovieStatus(i.key)
                if tempStatus != .none {
                    tempDict[tempStatus] = i.value
                }
            }
            
            for i in tempDict {
                dict[i.key] = i.value
            }
        }
        
        
        return dict
    }
    
    static func convertStringToGenre(_ genre: String) -> Genre? {
        Genre.allCases.first(where: { "\($0)".lowercased() == genre.lowercased() })
    }
    
    static func convertStringToProfession(_ profession: String) -> Profession? {
        Profession.allCases.first(where: { "\($0)".lowercased() == profession.lowercased() })
    }
    
    static func convertRatingToEnumValue(_ rating: Int?) -> Ratings? {
        Ratings.allCases.first(where: { $0.rawValue == rating })
    }
    
    static func getPeopleProfessionsDict(_ people: [Person]) -> String {
        var result: [Profession:String] = [:]
        var arrayPeople: [PersonViewModel] = []
        for i in people {
            let person = CustomFormatter.convertPersonToPersonVM(i)
            if let person = person {
                arrayPeople.append(person)
            }
        }
        
        var uniqueProfessions: [Profession] = []
        
        for i in arrayPeople {
            i.professions.forEach { profession in
                if !uniqueProfessions.contains(profession) {
                    uniqueProfessions.append(profession)
                }
            }
        }
        
        for i in uniqueProfessions {
            arrayPeople.forEach { person in
                if let exists = person.professions.first(where: { $0 == i }) {
                    if let existsProfession = result[exists] {
                        result[exists]! += ", \(person.name)"
                    } else {
                        result[exists] = person.name
                    }
                }
            }
        }
        
        var resultString = ""
        for i in result {
            resultString.append("\(i.key.localizeString()): \(i.value) \n")
        }
        
        return resultString
    }
    
    static func formatUserName(_ name: String) -> String? {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: name) {
            formatter.style = .abbreviated
            let newString = formatter.string(from: components).reversed()
            return String(newString)
        }
        return nil
    }
    
    static func convertNetworkUserToUser(_ user: NetworkUser) -> User {
        switch user.userType {
        case "Admin":
            return User(id: user.id, userName: user.userName, userType: .admin, token: user.token)
        default:
            return User(id: user.id, userName: user.userName, userType: .authUser, token: user.token)
        }
    }
    
    static func convertDurationToString(_ duration: Int) -> String {
        "\(duration) \(LocalizedStrings.min.localizeString())"
    }
    
    static func convertPersonToPersonVM(_ person: Person) -> PersonViewModel? {
        var proffesions: [Profession] = []
        for i in person.professions {
            if let proffession = convertStringToProfession(i) {
                proffesions.append(proffession)
            }
        }
        
        if proffesions.count == 0 {
            return nil
        } else {
            return PersonViewModel(id: person.id, name: person.name, age: person.age, image: person.image, professions: proffesions)
        }
    }
    
    static func convertDateToString(_ date: Int) -> String {
        let now = Date.now.unixTimestamp
        let diff = now - date
        
        let secondRange = 0...UnixConsts.unixSecond
        let secondsRange = UnixConsts.unixSecond...UnixConsts.unixMinute
        let minutesRange = UnixConsts.unixMinute...UnixConsts.unixHour
        let hoursRange = UnixConsts.unixHour...UnixConsts.unixDay
        let daysRange = UnixConsts.unixDay...UnixConsts.unixWeek
        let weeksRange = UnixConsts.unixWeek...UnixConsts.unixMonth
        let monthsRange = UnixConsts.unixMonth...UnixConsts.unixYear
        let yearsRange = UnixConsts.unixYear...Int.max
        let ranges: [ClosedRange<Int>] = [secondRange, secondsRange, minutesRange, hoursRange, daysRange, weeksRange, monthsRange, yearsRange]
        
        var resultStringDate = ""
        
        for i in ranges {
            if secondRange.contains(diff) {
                resultStringDate = "1 \(LocalizedStrings.sec.localizeString()) \(LocalizedStrings.ago.localizeString())"
                break
            }
            if i.contains(diff) {
                if i == secondsRange {
                    let seconds = diff / i.lowerBound
                    resultStringDate = "\(seconds) \(LocalizedStrings.sec.localizeString()) \(LocalizedStrings.ago.localizeString())"
                } else if i == minutesRange {
                    let minutes = diff / i.lowerBound
                    resultStringDate = "\(minutes) \(LocalizedStrings.min.localizeString()) \(LocalizedStrings.ago.localizeString())"
                } else if i == hoursRange {
                    let hours = diff / i.lowerBound
                    resultStringDate = "\(hours) \(LocalizedStrings.hour.localizeString()) \(LocalizedStrings.ago.localizeString())"
                } else if i == daysRange {
                    let days = diff / i.lowerBound
                    resultStringDate = "\(days) \(LocalizedStrings.day.localizeString()) \(LocalizedStrings.ago.localizeString())"
                } else if i == weeksRange {
                    let weeks = diff / i.lowerBound
                    resultStringDate = "\(weeks) \(LocalizedStrings.week.localizeString()) \(LocalizedStrings.ago.localizeString())"
                } else if i == monthsRange {
                    let months = diff / i.lowerBound
                    resultStringDate = "\(months) \(LocalizedStrings.month.localizeString()) \(LocalizedStrings.ago.localizeString())"
                } else if i == yearsRange {
                    let years = diff / i.lowerBound
                    resultStringDate = "\(years) \(LocalizedStrings.year.localizeString()) \(LocalizedStrings.ago.localizeString())"
                }
                
                break
            }
        }
        return resultStringDate
    }
    
    static func formatReleaseDateToString(unix: Int) -> String {
        let date = unix
        let now = Date.now.unixTimestamp
        if date > now {
            if date > now + UnixConsts.unixYear {
                return "\(date.date.get(.year)) \(LocalizedStrings.year.localizeString())"
            } else {
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale.current
                dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
                return "\(dateFormatter.string(from: date.date)) \(date.date.get(.year)) \(LocalizedStrings.year.localizeString())"
            }
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.current
            dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
            return "\(dateFormatter.string(from: date.date)) \(date.date.get(.year)) \(LocalizedStrings.year.localizeString())"
        }
    }
    
    static func countTotalRatings(_ ratings: [Int:Int]?) -> Int {
        var totalRatings = 0
        if let ratings = ratings {
            for i in ratings {
                totalRatings += i.value
            }
        }
        return totalRatings
    }
    
    
//    static func convertPeopleToDecription(_ people: [PersonViewModel]) -> String? {
//        
//    }
    
    enum LocalizedStrings: LocalizedStringKey {
        case of = "of"
        case ep = "ep"
        case announcement = "Announcement"
        case ago = "AgoLabel"
        case sec = "SecondShortLabel"
        case min = "MinuteShortLabel"
        case hour = "HourShortLabel"
        case day = "DayShortLabel"
        case week = "WeekShortLabel"
        case month = "MonthShortLabel"
        case year = "YearShortLabel"
        
        func localizeString() -> String {
            return NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
        }
    }
}

enum UnixConsts {
    static var unixYear = 31556926000
    static var unixMonth = 2629743000
    static var unixWeek = 604800000
    static var unixDay = 86400000
    static var unixHour = 3600000
    static var unixMinute = 60000
    static var unixSecond = 1000
}

enum Ratings: Int, CaseIterable {
    case zero = 0
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
}
