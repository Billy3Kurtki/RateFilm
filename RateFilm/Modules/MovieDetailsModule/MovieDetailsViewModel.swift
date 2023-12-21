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
    var user: User
    
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
    
    init(movieId: String, movieType: MovieType, user: User) {
        self.movieId = movieId
        self.movieType = movieType
        self.user = user
    }
    
    func convertFilmToCard(film: FilmExtended) -> MovieCard {
        let releaseDate: String
        let duration: String = CustomFormatter.convertDurationToString(film.duration)
        let avgRating = CustomFormatter.formatFloat(float: CustomFormatter.formatAvgRating(float: film.avgRating ?? 0))
        let ageRating = "\(film.ageRating)+"
        var arrayGenre: [Genre] = []
        for i in film.genre {
            if let genre = CustomFormatter.convertStringToGenre(i) {
                arrayGenre.append(genre)
            }
        }
        var status: MovieStatus = .none
        if let st = film.status {
            status = CustomFormatter.convertStringToMovieStatus(st)
        }
        
        
//        var arrayPerson: [PersonViewModel] = []
//        
//        for i in film.people {
//            if let person = CustomFormatter.convertPersonToPersonVM(i) {
//                arrayPerson.append(person)
//            }
//        }
        
        if let date = film.releaseDate {
            releaseDate = CustomFormatter.formatReleaseDateToString(unix: date)
        } else {
            releaseDate = String(localized: "comingSoon")
        }
        
        let statusOfPeople = CustomFormatter.convertStatusOfPeople(film.statusOfPeople)
        
        var arrayComments: [CommentViewModel] = []
        if let comments = film.comments {
            let tempComments = comments.sorted { $0.date > $1.date }
            for i in tempComments {
                let comment = CommentViewModel(comment: i)
                arrayComments.append(comment)
            }
        }
        
        let movieTypeString = String(localized: "Film")
        let countRatings = CustomFormatter.countTotalRatings(film.ratings)
        
        return MovieCard(id: film.id, name: film.name, description: film.description, releaseDate: releaseDate, duration: duration, previewImage: film.previewImage, images: film.images, avgRating: avgRating, ageRating: ageRating, genre: arrayGenre, peopleDescription: nil, isFavorite: film.isFavorite, movieType: .film, movieTypeString: movieTypeString, seasons: nil, status: status, isAnnouncement: film.isAnnouncement, isOngoing: false, seriesCount: nil, lastSeriesReleaseDate: nil, country: film.country, userRating: film.userRating, comments: arrayComments, ratings: film.ratings, countRatings: countRatings, statusOfPeople: statusOfPeople)
    }
    
    func convertSerialToCard(serial: SerialExtended) -> MovieCard {
        let releaseDate: String
        let avgRating = CustomFormatter.formatFloat(float: CustomFormatter.formatAvgRating(float: serial.avgRating ?? 0))
        let ageRating = "\(serial.ageRating)+"
        var arrayGenre: [Genre] = []
        for i in serial.genre {
            if let genre = CustomFormatter.convertStringToGenre(i) {
                arrayGenre.append(genre)
            }
        }
        var status: MovieStatus = .none
        if let st = serial.status {
            status = CustomFormatter.convertStringToMovieStatus(st)
        }
        
        
//        var arrayPerson: [PersonViewModel] = []
//
//        for i in film.people {
//            if let person = CustomFormatter.convertPersonToPersonVM(i) {
//                arrayPerson.append(person)
//            }
//        }
        
        if let date = serial.releaseDate {
            releaseDate = CustomFormatter.formatReleaseDateToString(unix: date)
        } else {
            releaseDate = String(localized: "comingSoon")
        }
        
        let statusOfPeople = CustomFormatter.convertStatusOfPeople(serial.statusOfPeople)
        
        let seriesCount: String = CustomFormatter.formatSeriesCountToString(countSeriesLeft: serial.countSeriesLeft, countSeriesMax: serial.countSeriesMax)
        
        var arrayComments: [CommentViewModel] = []
        if let comments = serial.comments {
            let tempComments = comments.sorted { $0.date > $1.date }
            for i in tempComments {
                let comment = CommentViewModel(comment: i)
                arrayComments.append(comment)
            }
        }
        
        let movieTypeString = String(localized: "Serial")
        let countRatings = CustomFormatter.countTotalRatings(serial.ratings)
        
        var arrayImages: [ImageModel] = []
        let seasons = serial.seasons
        for i in seasons {
            if let images = i.images {
                arrayImages.append(contentsOf: images)
            }
        }
        
        return MovieCard(id: serial.id, name: serial.name, description: serial.description, releaseDate: releaseDate, duration: nil, previewImage: serial.previewImage, images: arrayImages, avgRating: avgRating, ageRating: ageRating, genre: arrayGenre, peopleDescription: nil, isFavorite: serial.isFavorite, movieType: .serial, movieTypeString: movieTypeString, seasons: serial.seasons, status: status, isAnnouncement: serial.isAnnouncement, isOngoing: serial.isOngoing, seriesCount: seriesCount, lastSeriesReleaseDate: serial.lastSeriesReleaseDate, country: serial.country, userRating: serial.userRating, comments: arrayComments, ratings: serial.ratings, countRatings: countRatings, statusOfPeople: statusOfPeople)
    }
    
    func fetchMockMovie(_ movieType: MovieType) {
        switch movieType {
        case .film:
            let movieCard = convertFilmToCard(film: MovieDetailsViewModel.film1)
            card = movieCard
        case .serial:
            let movieCard = convertSerialToCard(serial: MovieDetailsViewModel.serial1)
            card = movieCard
        }
    }
    
    @MainActor
    func fetchMovie(user: User) async {
        switch movieType {
        case .film:
            let urlString = "\(ServerString.film.rawValue)/\(movieId)"
            let result = await networkService.fetchAsync(urlString: urlString, token: user.token, FilmExtended.self)
            
            switch result {
            case .success(let success):
                let convertedFilm = convertFilmToCard(film: success)
                card = convertedFilm
            case .failure(let failure):
                error = failure
            }
        case .serial:
            let urlString = "\(ServerString.serial.rawValue)/\(movieId)"
            let result = await networkService.fetchAsync(urlString: urlString, token: user.token, SerialExtended.self)
            
            switch result {
            case .success(let success):
                let convertedSerial = convertSerialToCard(serial: success)
                card = convertedSerial
            case .failure(let failure):
                error = failure
            }
        }
    }
    
    
}

extension MovieDetailsViewModel {
    static var film1 = FilmExtended(id: "1", name: "Абобусы атакуют", releaseDate: 1820241212121, description: "The lineLimit view modifier allows you to limit the number of lines that a Text view displays. You can also use the multilineTextAlignment view modifier to align the text within a multiline Text view. Here’s an example", duration: 120, previewImage: MainViewModel.image2, images: [MainViewModel.image4, MainViewModel.image5, MainViewModel.image1], avgRating: 2.0, ageRating: 16, genre: ["Action"], people: [], isFavorite: true, isAnnouncement: true, status: "Looking", country: "Россия", userRating: 1, comments: [comment1, comment2, comment3, comment4, comment5], ratings: [5:1, 4:2, 3:3, 2:4, 1:0], statusOfPeople: ["InThePlans" : 1])
    
    static var serial1 = SerialExtended(id: "2", name: "Абобусы атакуют", releaseDate: 1820241212121, description: "КThe lineLimit view modifier allows you to limit the number of lines that a Text view displays. You can also use the multilineTextAlignment view modifier to align the text within a multiline Text view. Here’s an example", previewImage: MainViewModel.image2, avgRating: 2.0, seasons: MainViewModel.seasons1, ageRating: 16, genre: ["Action"], people: [], isFavorite: true, status: "Looking", isAnnouncement: true, isOngoing: false, countSeriesLeft: 0, countSeriesMax: nil, country: "Россия", userRating: 1, comments: [comment1, comment2, comment3, comment4, comment5], ratings: [5:1, 4:2, 3:3, 2:4, 1:0], statusOfPeople: ["InThePlans" : 1])
    
    
    static var comment1 = Comment(id: "1", user: userMini1, text: "Понаделают конечно....", date: 1703197561000, countLike: 2)
    static var comment2 = Comment(id: "2", user: userMini1, text: "Понаделают конечно...Хлам.", date: 1703167568000, countLike: 2)
    static var comment3 = Comment(id: "3", user: userMini1, text: "Понаделают конечно...Шлак.", date: 1703197558000, countLike: 3)
    static var comment4 = Comment(id: "4", user: userMini1, text: "Понаделают конечно...Ведро.", date: 1703197368000, countLike: 4)
    static var comment5 = Comment(id: "5", user: userMini1, text: "Понаделают конечно...AFaFAF.", date: 1702197568000, countLike: 4)
    static var userMini1 = UserMini(id: "1", username: "Clown", image: MainViewModel.image1)
}
