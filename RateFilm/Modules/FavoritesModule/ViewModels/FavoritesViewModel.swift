//
//  FavoritesViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 03.12.2023.
//

import Foundation
import Observation

@Observable
final class FavoritesViewModel {
    var snippets: [SnippetViewModel] = []
    var searchResults: [SnippetViewModel] = []
    
    let networkService = NetworkService()
    var error: NetworkError?
    
    init() {
        
    }
    
    func getFilteredList(by: FavoritesViewSelections) -> [SnippetViewModel] {
        switch by {
//        case .history:
//            return [] // пока так
        case .favourite:
            return snippets.filter { $0.isFavorite == true }
        case .looking:
            return snippets.filter { $0.movieStatus == .looking }
        case .inThePlans:
            return snippets.filter { $0.movieStatus == .inThePlans }
        case .viewed:
            return snippets.filter { $0.movieStatus == .viewed }
        case .postponed:
            return snippets.filter { $0.movieStatus == .postponed }
        case .abandoned:
            return snippets.filter { $0.movieStatus == .abandoned }
        }
    }
    
    func convertFilmsToSnippetVMs(_ films: [Film]) -> [SnippetViewModel] {
        // MARK: Перегон фильмов
        var resultSnippets: [SnippetViewModel] = []
        
        let now = Date.now.unixTimestamp
        let startDate: Int = now - UnixConsts.unixMonth
        let endDate: Int = now
        let range = startDate...endDate
        
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
                }
            } else {
                realeseDate = String(localized: "comingSoon")
            }
            
            var arrayGenre: [Genre] = []
            for j in i.genre {
                if let genre = CustomFormatter.convertStringToGenre(j) {
                    arrayGenre.append(genre)
                }
            }
            
            if arrayGenre.count == 0 { // если не сконвертился ни один жанр, то в мусорку
                continue
            }
            
            let snippetVM = SnippetViewModel(id: i.id, name: i.name, releaseDate: realeseDate, description: i.description, previewImage: i.previewImage.url, avgRating: avgRating, movieType: .film, isFavorite: i.isFavorite, movieStatus: movieStatus, genre: arrayGenre)
            resultSnippets.append(snippetVM)
        }
        
        return resultSnippets
    }
    
    func convertSerialsToSnippetVMs(_ serials: [Serial]) -> [SnippetViewModel] {
        // MARK: Перегон сериалов
        var resultSnippets: [SnippetViewModel] = []
        
        for i in serials {
            var avgRating: String?
            var realeseDate: String?
            let seriesCount: String = CustomFormatter.formatSeriesCountToString(countSeriesLeft: i.countSeriesLeft, countSeriesMax: i.countSeriesMax)
            var movieStatus = MovieStatus.none
            
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
            
            var arrayGenre: [Genre] = []
            for j in i.genre {
                if let genre = CustomFormatter.convertStringToGenre(j) {
                    arrayGenre.append(genre)
                }
            }
            
            if arrayGenre.count == 0 { // если не сконвертился ни один жанр, то в мусорку
                continue
            }
            
            let snippetVM = SnippetViewModel(id: i.id, name: i.name, releaseDate: realeseDate, description: i.description, previewImage: i.previewImage.url, avgRating: avgRating, seriesCount: seriesCount, movieType: .serial, isFavorite: i.isFavorite, movieStatus: movieStatus, genre: arrayGenre)
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
