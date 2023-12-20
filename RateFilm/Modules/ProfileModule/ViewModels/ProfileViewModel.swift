//
//  ProfileViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 12.12.2023.
//

import Foundation
import Observation

@Observable
final class ProfileViewModel {
    var users: [UserMiniViewModel] = []
    var searchResults: [UserMiniViewModel] = []
    var networkService = NetworkService()
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
    
    @MainActor
    func getUsersByUsernameAsync(username: String) async {
        let body = ["\(username)": username.lowercased()]
        let result = await networkService.fetchAsync(urlString: ServerString.users.rawValue, body: body, [UserMini].self)
        switch result {
        case .success(let success):
            self.searchResults = []
            for i in success {
                let userMiniVM = UserMiniViewModel(userMini: i)
                self.searchResults.append(userMiniVM)
            }
        case .failure(let failure):
            error = failure
        }
    }
    
    func fetchMockUsers() {
        let mockUsers: [UserMini] = [ProfileViewModel.mockUserMini1, ProfileViewModel.mockUserMini2, ProfileViewModel.mockUserMini3, ProfileViewModel.mockUserMini4]
        self.users = mockUsers.map { UserMiniViewModel(userMini: $0) }
    }
}

extension ProfileViewModel {
    static let mockUser1 = UserExtended(id: "1", username: "clown_eye", image: ImageModel(id: "1", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvd0sBonCGb8bGoHNjUMOspgI3AoI_UR89oQ&usqp=CAU"), email: "email@gmail.com", statisticStatus: ["Looking" : 33, "Abandoned" : 333, "Postponed" : 2, "Viewed": 44, "InThePlans" : 0])
    static let mockUser2 = UserExtended(id: "2", username: "Vasya_IO", image: ImageModel(id: "1", url: "broken"), email: "email@gmail.com", statisticStatus: ["Looking" : 33, "Abandoned" : 333, "Postponed" : 2, "Viewed": 44, "InThePlans" : 0])
    static let mockUser3 = UserExtended(id: "3", username: "Balbes_UI", image: ImageModel(id: "3", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvd0sBonCGb8bGoHNjUMOspgI3AoI_UR89oQ&usqp=CAU"), email: "email@gmail.com", statisticStatus: ["Looking" : 33, "Abandoned" : 333, "Postponed" : 2, "Viewed": 44, "InThePlans" : 0])
    static let mockUser4 = UserExtended(id: "4", username: "EYE jj", email: "email@gmail.com", statisticStatus: ["Looking" : 33, "Abandoned" : 333, "Postponed" : 2, "Viewed": 44, "InThePlans" : 0])
    
    static let mockUserMini1: UserMini = UserMini(id: "1", username: "clown_eye", image: ImageModel(id: "1", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvd0sBonCGb8bGoHNjUMOspgI3AoI_UR89oQ&usqp=CAU"))
    static let mockUserMini2: UserMini = UserMini(id: "2", username: "Vasya_IO", image: ImageModel(id: "1", url: "broken"))
    static let mockUserMini3: UserMini = UserMini(id: "3", username: "Balbes_UI", image: ImageModel(id: "1", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvd0sBonCGb8bGoHNjUMOspgI3AoI_UR89oQ&usqp=CAU"))
    static let mockUserMini4: UserMini = UserMini(id: "4", username: "EYE jj")
    
    static let currentMockUser = mockUser4
    
    static let users: [UserExtended] = [mockUser1, mockUser2, mockUser3, mockUser4]
}
