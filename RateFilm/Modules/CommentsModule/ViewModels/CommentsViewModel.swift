//
//  CommentsViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 22.12.2023.
//

import Foundation
import Observation

@Observable
final class CommentsViewModel {
    var movieId: String
    var movieType: MovieType
    var user: User
    
    var comments: [CommentVM] = []
    var error: NetworkError?
    var networkService = NetworkService()
    
    var countNeedComments = 50
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
    
    func convertCommentsToCommentVMs(_ comments: [Comment]) -> [CommentVM] {
        var arrayComments: [CommentVM] = []
        let tempComments = comments.sorted { $0.date > $1.date }
        for i in tempComments {
            let comment = CommentVM(comment: i)
            arrayComments.append(comment)
        }
        
        return arrayComments
    }
    
//    func loadCommentsIfNeeded(comment: CommentVM) async {
//        let thresholdIndex = comments.index(comments.endIndex, offsetBy: -5)
//        if comments.firstIndex(where: { $0.id == comment.id }) == thresholdIndex {
//            countNeedComments += 20
//            await fetchCommentsAsync()
//        }
//    }
    
    @MainActor
    func fetchCommentsAsync() async {
        comments = []
        switch movieType {
        case .film:
            let body: [String : String] = ["filmId":movieId, "count":"\(countNeedComments)"]
            let result = await networkService.fetchAsync(urlString: ServerString.filmComments, token: user.token, body: body, [Comment].self)
            
            switch result {
            case .success(let success):
                let convertedComments = convertCommentsToCommentVMs(success)
                comments.append(contentsOf: convertedComments)
            case .failure(let failure):
                error = failure
            }
        case .serial:
            let body: [String : String] = ["serialId":movieId, "count":"\(countNeedComments)"]
            let result = await networkService.fetchAsync(urlString: ServerString.serialComments, token: user.token, body: body, [Comment].self)
            
            switch result {
            case .success(let success):
                let convertedComments = convertCommentsToCommentVMs(success)
                comments.append(contentsOf: convertedComments)
            case .failure(let failure):
                error = failure
            }
        }
    }
    
    @MainActor
    func addComment(text: String) async -> Bool {
        switch movieType {
        case .film:
            let body: [String : String] = ["movieId":movieId, "commentText":text]
            let result = await networkService.postAsync(urlString: ServerString.filmComments, body: body, method: .post, token: user.token)
            
            switch result {
            case .success(_):
                await fetchCommentsAsync()
                return true
            case .failure(let failure):
                error = failure
                return false
            }
        case .serial:
            let body: [String : String] = ["movieId":movieId, "commentText":text]
            let result = await networkService.postAsync(urlString: ServerString.serialComments, body: body, method: .post, token: user.token)
            
            switch result {
            case .success(_):
                await fetchCommentsAsync()
                return true
            case .failure(let failure):
                print(failure)
                error = failure
                return false
            }
        }
    }
}
