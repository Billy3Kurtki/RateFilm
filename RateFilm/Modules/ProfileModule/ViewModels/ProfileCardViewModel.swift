//
//  ProfileCardViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 18.12.2023.
//

import Foundation
import Observation

@Observable
final class ProfileCardViewModel {
    var username: String
    var networkService = NetworkService()
    var user: UserViewModel?
    var error: NetworkError?
    //    var localizedError: String? {
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
    //        case nil:
    //            <#code#>
    //        }
    //    }
    
    init(username: String) {
        self.username = username
    }
    
    func fetchMockUser() {
        if let user = ProfileViewModel.users.first(where: { $0.username == username }) {
            self.user = UserViewModel(user: user)
        }
    }
    
    @MainActor
    func fetchUserAsync() async {
        let body = ["username": username]
        let result = await networkService.fetchAsync(urlString: ServerString.user, body: body, UserExtended.self)
        switch result {
        case .success(let success):
            self.user = UserViewModel(user: success)
        case .failure(let failure):
            error = failure
        }
    }
}
