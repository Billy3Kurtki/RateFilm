//
//  ListViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 11.10.2023.
//

import SwiftUI
import Observation

@Observable
final class MainViewModel {
    var snippets: [SnippetMainViewModel] = []
    var searchResults: [SnippetViewModel] = []
    
    let networkService = NetworkService()
    var error: NetworkError?
    
    init() {
        
    }
    
    func getFilteredList(by: MainViewSelections) -> [SnippetViewModel] {
        switch by {
//        case .mySelection:
//            snippets.filter { $0.mainViewSelection.contains(.mySelection) }.map { $0.snippet }
        case .lastReleased:
            snippets.filter { $0.isLastRealesed == true }.map { $0.snippet }
        case .ongoings:
            snippets.filter { $0.isOngoing == true }.map { $0.snippet }
        case .announcement:
            snippets.filter { $0.isAnnouncement == true }.map { $0.snippet }
        case .completed:
            snippets.filter { $0.isAnnouncement == false && $0.isOngoing == false }.map { $0.snippet }
        case .serials:
            snippets.map { $0.snippet }.filter { $0.movieType == .serial }
        case .films:
            snippets.map { $0.snippet }.filter { $0.movieType == .film }
        }
    }
    
    func convertFilmsToSnippetMainVMs(_ films: [Film]) -> [SnippetMainViewModel] {
        // MARK: Перегон фильмов
        var resultSnippets: [SnippetMainViewModel] = []
        
        let now = Date.now.unixTimestamp
        let startDate: Int = now - UnixConsts.unixMonth
        let endDate: Int = now
        let range = startDate...endDate
        var isLastRealesed = false
        
        for i in films {
            var avgRating: String?
            var realeseDate: String?
            var movieStatus = MovieStatus.none
            
            if let status = i.status {
                movieStatus = CustomFormatter.convertStringToMovieStatus(status)
            }
            
            if let date = i.releaseDate {
                realeseDate = CustomFormatter.formatDateToCustomString(unix: date)
                if realeseDate == nil {
                    avgRating = CustomFormatter.formatFloat(float: CustomFormatter.formatAvgRating(float: i.avgRating))
                    if range.contains(date) {
                        isLastRealesed = true
                    }
                }
            } else {
                realeseDate = String(localized: "comingSoon")
            }
            
            let snippetVM = SnippetViewModel(id: i.id, name: i.name, releaseDate: realeseDate, description: i.description, previewImage: i.previewImage.url, avgRating: avgRating, movieType: .film, isFavorite: i.isFavorite, movieStatus: movieStatus)
            let snippetMainVM = SnippetMainViewModel(snippet: snippetVM, isAnnouncement: i.isAnnouncement, isLastRealesed: isLastRealesed)
            resultSnippets.append(snippetMainVM)
        }
        
        return resultSnippets
    }
    
    func convertSerialsToSnippetMainVMs(_ serials: [Serial]) -> [SnippetMainViewModel] {
        // MARK: Перегон сериалов
        var resultSnippets: [SnippetMainViewModel] = []
        
        for i in serials {
            var avgRating: String?
            var realeseDate: String?
            var seriesCount: String = CustomFormatter.formatSeriesCountToString(countSeriesLeft: i.countSeriesLeft, countSeriesMax: i.countSeriesMax)
            var movieStatus = MovieStatus.none
            var isLastRealese = false
            
            if let status = i.status {
                movieStatus = CustomFormatter.convertStringToMovieStatus(status)
            }
            
            if let date = i.releaseDate {
                realeseDate = CustomFormatter.formatDateToCustomString(unix: date)
                if realeseDate == nil {
                    avgRating = "• \(CustomFormatter.formatFloat(float: CustomFormatter.formatAvgRating(float: i.avgRating)))"
                }
            } else {
                realeseDate = String(localized: "comingSoon")
            }
            
            if let _ = i.lastSeriesRealeseDate {
                isLastRealese = true
            }
            
            let snippetVM = SnippetViewModel(id: i.id, name: i.name, releaseDate: realeseDate, description: i.description, previewImage: i.previewImage.url, avgRating: avgRating, seriesCount: seriesCount, movieType: .serial, isFavorite: i.isFavorite, movieStatus: movieStatus)
            let snippetMainVM = SnippetMainViewModel(snippet: snippetVM, isAnnouncement: i.isAnnouncement, isOngoing: i.isOngoing, isLastRealesed: isLastRealese)
            resultSnippets.append(snippetMainVM)
        }
        
        return resultSnippets
    }
    
    func fetchMockData() {
        let convertedFilms = convertFilmsToSnippetMainVMs(MainViewModel.films)
        let convertedSerials = convertSerialsToSnippetMainVMs(MainViewModel.serials)
        let movies = convertedFilms + convertedSerials
        snippets = movies
    }
    
    @MainActor
    func fetchDataAsync(user: User) async {
        let result = await networkService.fetchAsync(urlString: ServerString.movies.rawValue, token: user.token, NetworkMovies.self)
        switch result {
        case .success(let success):
            let convertedFilms = convertFilmsToSnippetMainVMs(success.films)
            let convertedSerials = convertSerialsToSnippetMainVMs(success.serials)
            let movies = convertedFilms + convertedSerials
            snippets = movies
        case .failure(let failure):
            error = failure
        }
    }
}

extension MainViewModel {
    static let films: [Film] = [
        Film(id: "1", name: "biba1", releaseDate: 1698144372325, description: "bobaboba bobabobaboba bobabobabobab obabobabobaboba bobabobabobabobabo babobabobabobab obabobabobabobabobabo babobabobabobab obabobabobabobabobabobabobabobabobaboba", previewImage: image5, avgRating: 5.0, ageRating: 15, genre: [Genre.action], isAnnouncement: false, isFavorite: false, status: "Watching", country: "США"),
        Film(id: "2", name: "biba2", releaseDate: 920241212121, description: "bobaboba bobabobaboba bobabobabobab obabobabobaboba bobabobabobabobabo babobabobabobab obabobabobabobabobabo babobabobabobab obabobabobabobabobabobabobabobabobaboba", previewImage: image5, avgRating: 4.0, ageRating: 15, genre: [Genre.action], isAnnouncement: false, isFavorite: true, status: .none),
        Film(id: "3", name: "biba3", description: "boba3", previewImage: image3, avgRating: 2.0, ageRating: 15, genre: [Genre.action], isAnnouncement: true, isFavorite: true, status: "InPlans", country: "Россия", userRating: 2),
        Film(id: "4", name: "biba4", releaseDate: 1700315320619, description: "boba4", previewImage: image5, avgRating: 4.2,ageRating: 15, genre: [Genre.action], isAnnouncement: true, isFavorite: false, userRating: 1),
        Film(id: "5", name: "biba5", releaseDate: 1820241212121, description: "boba", previewImage: image2, avgRating: 2.5, ageRating: 15, genre: [Genre.action], isAnnouncement: true, isFavorite: false, status: "Postponed"),
        Film(id: "6", name: "biba6", description: "boba2", previewImage: image1, avgRating: 3.3, ageRating: 15, genre: [Genre.action], isAnnouncement: true, isFavorite: true, status: "Abandoned", country: "Россия"),
        Film(id: "7", name: "biba7", releaseDate: 1699122213, description: "boba3", previewImage: image2, avgRating: 2.6, ageRating: 15, genre: [Genre.action], isAnnouncement: false, isFavorite: false),
        Film(id: "8", name: "biba8", releaseDate: 1702123700619, description: "boba4", previewImage: image1, avgRating: 5.0, ageRating: 15, genre: [Genre.action], isAnnouncement: true, isFavorite: false, status: "Watched"),
        Film(id: "9", name: "biba9", releaseDate: 1703123001619, description: "boba5", previewImage: image2, avgRating: 5.0, ageRating: 15, genre: [Genre.action], isAnnouncement: true, isFavorite: true, country: "Россия", userRating: 5)
    ]
    
    static let serials: [Serial] = [
        Serial(id: "11", name: "Крокодил Гена выходит на охоту", releaseDate: 1810241212121, description: "Гена шёл-шёл, шёл-шёл, так и не пришёл.", previewImage: image5, avgRating: 3.0, ageRating: 12, moveTypes: [.action], isFavorite: false, status: "Watched", isAnnouncement: true, isOngoing: false, countSeriesLeft: 0, countSeriesMax: 18, country: "Россия"),
        Serial(id: "222", name: "Мышь подкралась незаметно", releaseDate: 1699123761619, description: "Бежит, бежит, оп, упала", previewImage: image1, avgRating: 4.0, ageRating: 12, moveTypes: [.action], isFavorite: true, status: "Watching", isAnnouncement: false, isOngoing: true, countSeriesLeft: 1, countSeriesMax: 8, country: "Великобритания"),
        Serial(id: "3321", name: "Шарик взорвался", description: "Жалко конечно даааааа", previewImage: image3, avgRating: 5.0, ageRating: 12, moveTypes: [.action], isFavorite: false, isAnnouncement: true, isOngoing: false, countSeriesLeft: 0, countSeriesMax: 8, country: "США"),
        Serial(id: "43123", name: "Винни полетел", description: "Бывает конечно даааааа", previewImage: image2, avgRating: 5.0, ageRating: 12, moveTypes: [.action], isFavorite: false, status: "Abandoned", isAnnouncement: true, isOngoing: false, countSeriesLeft: 0, countSeriesMax: 8, country: "Россия", userRating: 2),
        Serial(id: "54124245", name: "Фунтик толкает машину дядюшки Мокуса", releaseDate: 1823212121, description: "Тянет-потянет, вытащить так и не смог", previewImage: image1, avgRating: 5.0, ageRating: 12, moveTypes: [.action], isFavorite: true, isAnnouncement: false, isOngoing: false, countSeriesLeft: 3, country: "Япония", userRating: 3)
    ]
    
    static let seasons1: [Season] = [
        Season(id: "1", releaseDate: 1699123761620, description: "", avgRating: 0.0, series: series1),
        Season(id: "2", releaseDate: 1699123762619, description: "", avgRating: 0.0, series: []),
        Season(id: "3", releaseDate: 1671023761619, description: "", avgRating: 0.0, series: series1)
    ]
    
    static let seasons2: [Season] = [
        Season(id: "1", releaseDate: 1823212121, description: "", avgRating: 0.1, series: [])
    ]
    
    static let seasons3: [Season] = [
        Season(id: "2", releaseDate: 1699123761619, description: "", avgRating: 0.0, series: []),
        Season(id: "4", releaseDate: 1699121514, description: "", avgRating: 0.0, series: series1)
    ]
    
    static let series1: [Series] = [
        Series(id: "41234", name: "Выход крокодильчика на свободу", duration: 25, realeseDate: 1810251212121, previewImage: image1, avgRating: 0.2),
        Series(id: "312412", name: "Гена переходит дорогу", duration: 25, realeseDate: 1810251212121, previewImage: image2, avgRating: 0.3),
        Series(id: "12321", name: "Гена выносит дорогу", duration: 25, realeseDate: 1810251212121, previewImage: image3, avgRating: 0.3)
    ]
    
    static let image1: ImageModel = ImageModel(id: "324134", url: "https://i.pinimg.com/236x/1b/9b/34/1b9b3430f3e89b95c22937d7c353737e.jpg")
    static let image2: ImageModel = ImageModel(id: "32411234", url:  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvd0sBonCGb8bGoHNjUMOspgI3AoI_UR89oQ&usqp=CAU")
    static let image3: ImageModel = ImageModel(id: "32411234", url: "https://www.codeproject.com/KB/GDI-plus/ImageProcessing2/img.jpg")
    static let image4: ImageModel = ImageModel(id: "32411234", url: "https://img.freepik.com/premium-photo/dcim-101media-dji-0067-jpg_665346-20571.jpg")
    static let image5: ImageModel = ImageModel(id: "32411234", url: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/JPEG_example_down.jpg/350px-JPEG_example_down.jpg")
    
    static let person1: Person = Person(id: "1231234afaf", name: "Керамзит Джонсон", age: 50, image: image5, professions: [.Actor])
    static let person2: Person = Person(id: "12312412", name: "Сильвестр с талоном", age: 50, image: image5, professions: [.Actor, .Autor])
    static let person3: Person = Person(id: "12312412", name: "Джордж Мартин", age: 50, image: image5, professions: [.Autor])
}
