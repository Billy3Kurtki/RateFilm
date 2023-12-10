//
//  MovieDetailsViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 05.12.2023.
//

import Foundation
import Observation

@Observable
final class MovieDetailsViewModel {
    var movieId: String
    var movieType: MovieType
    
    var card: MovieCard?
    var error: NetworkError?
    var networkService = NetworkService()
//    var localizedError: String {
//        switch error {
//        case .invalidUrl:
//            <#code#>
//        case .networkError:
//            <#code#>
//        case .dataError:
//            <#code#>
//        case .parseError:
//            <#code#>
//        case .unexpectedResponse:
//            <#code#>
//        case .failedResponse(let hTTPURLResponse):
//            <#code#>
//        case .requestError:
//            <#code#>
//        case .serverError:
//            <#code#>
//        }
//    }
    
    init(movieId: String, movieType: MovieType) {
        self.movieId = movieId
        self.movieType = movieType
    }
    
//    @MainActor
//    func fetchMovie(user: User) async {
//        switch movieType {
//        case .film:
//            let result = await networkService.fetchAsync(urlString: ServerString.film.rawValue, token: user.token, Film.self)
//            
//            switch result {
//            case .success(let success):
//                let convertedFilm = convertFilmToCard(film: Film)
//                card = movies
//            case .failure(let failure):
//                error = failure
//            }
//        case .serial:
//            <#code#>
//        }
//    }
    
    
}
