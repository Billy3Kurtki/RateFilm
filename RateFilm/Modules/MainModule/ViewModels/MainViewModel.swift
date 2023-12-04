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
    var searchResults: [SnippetMainViewModel] = []
    
    let networkService = NetworkService()
    var error: NetworkError?
    
    init() {
        
    }
    
    func getFilteredList(by: MainViewSelections) -> [SnippetMainViewModel] {
        switch by {
        case .mySelection:
            return snippets.filter { $0.mainViewSelection.contains(.mySelection) }
        case .lastReleased:
            return snippets.filter { $0.mainViewSelection.contains(.lastReleased) }
        case .ongoings:
            return snippets.filter { $0.mainViewSelection.contains(.ongoings) }
        case .announcement:
            return snippets.filter { $0.mainViewSelection.contains(.announcement) }
        case .completed:
            return snippets.filter { $0.mainViewSelection.contains(.completed) }
        case .serials:
            return snippets.filter { $0.mainViewSelection.contains(.serials) }
        case .films:
            return snippets.filter { $0.mainViewSelection.contains(.films) }
        }
    }
    
    func convertFilmsToSnippetVMs(_ films: [Film]) -> [SnippetMainViewModel] {
        // MARK: Перегон фильмов
        var resultSnippets: [SnippetMainViewModel] = []
        
        let now = Date.now.unixTimestamp
        let startDate: Int = now - 2 * UnixConsts.unixMonth
        let endDate: Int = now
        let range = startDate...endDate
        for i in films {
            var avgRating: String?
            var realeseDate: String?
            var selections: [MainViewSelections] = [.films]
            //допилить
            if let date = i.releaseDate {
                realeseDate = CustomFormatter.formatDateToCustomString(unix: date)
                if realeseDate == nil {
                    avgRating = CustomFormatter.formatFloat(float: CustomFormatter.formatAvgRating(float: i.avgRating))
                    if range.contains(date) {
                        selections.append(.lastReleased)
                    }
                } else {
                    selections.append(.announcement)
                }
            } else {
                realeseDate = String(localized: "comingSoon")
                selections.append(.announcement)
            }
            
            let snippetVM = SnippetMainViewModel(id: i.id, name: i.name, releaseDate: realeseDate, description: i.description, previewImage: i.previewImage.url, avgRating: avgRating, mainViewSelection: selections, isFavorite: i.isFavorite, favoriteSelection: i.favoritesSelection)
            resultSnippets.append(snippetVM)
        }
        return resultSnippets
    }
    
    func convertSerialsToSnippetVMs(_ serials: [Serial]) -> [SnippetMainViewModel] {
        // MARK: Перегон сериалов
        var resultSnippets: [SnippetMainViewModel] = []
        
        for i in serials {
            var avgRating: String?
            var realeseDate: String?
            var seriesCount: String
            var selections: [MainViewSelections] = []
            
            (seriesCount, selections) = CustomFormatter.formatSeriesCountToString(seasons: i.seasons)
            if let date = i.releaseDate {
                realeseDate = CustomFormatter.formatDateToCustomString(unix: date)
                if realeseDate == nil {
                    avgRating = "• \(CustomFormatter.formatFloat(float: CustomFormatter.formatAvgRating(float: i.avgRating)))"
                } else {
                    if !selections.contains(.announcement) { // если по сезонам было определено, что это не анонс, а по дате выхода сериала это анонс, то это неправильные данные, скип
                        continue
                    }
                    if selections.contains(.completed) {
                        selections.removeAll(where: { $0 == .completed })
                    }
                }
            } else {
                realeseDate = String(localized: "comingSoon")
                selections.append(.announcement)
            }
            
            let snippetVM = SnippetMainViewModel(id: i.id, name: i.name, releaseDate: realeseDate, description: i.description, previewImage: i.previewImage.url, avgRating: avgRating, seriesCount: seriesCount, mainViewSelection: selections, isFavorite: i.isFavorite, favoriteSelection: i.favoritesSelection)
            resultSnippets.append(snippetVM)
        }
        return resultSnippets
    }
    
    func fetchMockData() {
        let convertedFilms = convertFilmsToSnippetVMs(MainViewModel.films)
        let convertedSerials = convertSerialsToSnippetVMs(MainViewModel.serials)
        let movies = convertedFilms + convertedSerials
        snippets = movies
    }
    
    @MainActor
    func fetchDataAsync(user: User) async {
        let result = await networkService.fetchAsync(urlString: ServerString.movies.rawValue, token: user.token, NetworkMovies.self)
        switch result {
        case .success(let success):
            let convertedFilms = convertFilmsToSnippetVMs(success.films)
            let convertedSerials = convertSerialsToSnippetVMs(success.serials)
            let movies = convertedFilms + convertedSerials
            snippets = movies
        case .failure(let failure):
            error = failure
        }
    }
}

extension MainViewModel {
    static let films: [Film] = [
        Film(id: "1", name: "biba1", releaseDate: 1699544372325, description: "bobaboba bobabobaboba bobabobabobab obabobabobaboba bobabobabobabobabo babobabobabobab obabobabobabobabobabo babobabobabobab obabobabobabobabobabobabobabobabobaboba", duration: 200, previewImage: image5, avgRating: 5.0, ageRating: 15, genre: [Genre.action], people: [person1], isFavorite: false, favoritesSelection: .looking),
        Film(id: "2", name: "biba2", releaseDate: 920241212121, description: "bobaboba bobabobaboba bobabobabobab obabobabobaboba bobabobabobabobabo babobabobabobab obabobabobabobabobabo babobabobabobab obabobabobabobabobabobabobabobabobaboba", duration: 200, previewImage: image5, avgRating: 4.0, ageRating: 15, genre: [Genre.action], people: [person3, person1, person2], isFavorite: true, favoritesSelection: .none),
        Film(id: "3", name: "biba3", description: "boba3", duration: 200, previewImage: image3, avgRating: 2.0, ageRating: 15, genre: [Genre.action], people: [person1], isFavorite: true, favoritesSelection: .abandoned),
        Film(id: "4", name: "biba4", releaseDate: 1700315320619, description: "boba4", duration: 200, previewImage: image5, avgRating: 4.2,ageRating: 15, genre: [Genre.action], people: [person3, person2], isFavorite: false, favoritesSelection: .none),
        Film(id: "5", name: "biba5", releaseDate: 1820241212121, description: "boba", duration: 200, previewImage: image2, avgRating: 2.5, ageRating: 15, genre: [Genre.action], people: [person3], isFavorite: false, favoritesSelection: .postponed),
        Film(id: "6", name: "biba6", description: "boba2", duration: 200, previewImage: image1, avgRating: 3.3, ageRating: 15, genre: [Genre.action], people: [person3, person1, person2], isFavorite: true, favoritesSelection: .inThePlans),
        Film(id: "7", name: "biba7", releaseDate: 1699122213, description: "boba3", duration: 200, previewImage: image2, avgRating: 2.6, ageRating: 15, genre: [Genre.action], people: [person2], isFavorite: false, favoritesSelection: .looking),
        Film(id: "8", name: "biba8", releaseDate: 1699123700619, description: "boba4", duration: 200, previewImage: image1, avgRating: 5.0, ageRating: 15, genre: [Genre.action], people: [person1], isFavorite: false, favoritesSelection: .viewed),
        Film(id: "9", name: "biba9", releaseDate: 1699123001619, description: "boba5", duration: 200, previewImage: image2, avgRating: 5.0, ageRating: 15, genre: [Genre.action], people: [person3, person1], isFavorite: true, favoritesSelection: .none)
    ]
    
    static let serials: [Serial] = [
        Serial(id: "1", name: "Крокодил Гена выходит на охоту", releaseDate: 1810241212121, description: "Гена шёл-шёл, шёл-шёл, так и не пришёл.", duration: 200, previewImage: image5, avgRating: 3.0, seasons: [], ageRating: 12, moveTypes: [.action], author: "Alyshka", isFavorite: false, favoritesSelection: .none),
        Serial(id: "2", name: "Мышь подкралась незаметно", releaseDate: 1699123761619, description: "Бежит, бежит, оп, упала", duration: 200, previewImage: image1, avgRating: 4.0, seasons: seasons1, ageRating: 12, moveTypes: [.action], author: "Alyshka", isFavorite: true, favoritesSelection: .looking),
        Serial(id: "3", name: "Шарик взорвался", description: "Жалко конечно даааааа", duration: 200, previewImage: image3, avgRating: 5.0, seasons: seasons3, ageRating: 12, moveTypes: [.action], author: "Alyshka", isFavorite: false, favoritesSelection: .none),
        Serial(id: "4", name: "Винни полетел", description: "Бывает конечно даааааа", duration: 200, previewImage: image2, avgRating: 5.0, seasons: [], ageRating: 12, moveTypes: [.action], author: "Alyshka", isFavorite: false, favoritesSelection: .abandoned),
        Serial(id: "5", name: "Фунтик толкает машину дядюшки Мокуса", releaseDate: 1823212121, description: "Тянет-потянет, вытащить так и не смог", duration: 200, previewImage: image1, avgRating: 5.0, seasons: seasons2, ageRating: 12, moveTypes: [.action], author: "Alyshka", isFavorite: true, favoritesSelection: .none)
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
