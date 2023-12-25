//
//  CommentCellViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 24.12.2023.
//

import Foundation
import Observation

@Observable
final class CommentCellViewModel {
    var comment: CommentVM
    
    var networkService = NetworkService()
    var error: NetworkError?
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
    
    init(comment: CommentVM) {
        self.comment = comment
    }
    
    @MainActor
    func changeCommentLike(user: User) async {
        let urlString = "\(ServerString.comment)/\(comment.id)"
        let body: [String : String] = [:]
//        let body: [String : String] = ["commentId":comment.id]
        let result = await networkService.postAsync(urlString: urlString, body: body, method: .put, token: user.token)
//        let result = await networkService.postAsync(urlString: ServerString.comment, body: body, method: .post, token: user.token)
        
        switch result {
        case .success(_):
            comment.isLiked.toggle()
            if comment.isLiked {
                comment.countLike += 1
            } else {
                comment.countLike -= 1
            }
        case .failure(let failure):
            print(failure)
            error = failure
        }
    }
}
