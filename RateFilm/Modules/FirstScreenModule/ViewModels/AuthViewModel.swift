//
//  AuthViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 16.11.2023.
//

import Foundation
import Observation

@Observable
final class AuthViewModel {
    var currentUser: User?
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
//        case nil:
//            ""
//        }
//    }
    
    init(currentUser: User? = nil) {
        self.currentUser = currentUser
    }
    
    @MainActor
    func signIn(login: String, password: String) async {
        // сервер ещё в разработке
//        let loginModel = Login(userLogin: login, password: password)
//        
//        await networkService.post(urlString: ServerString.login.rawValue, 
//                                  body: loginModel,
//                                  method: .post) { (result: Result<Data?, NetworkError>) in
//            switch result {
//            case .success(let data):
//                guard let data = data else {
//                    self.error = NetworkError.dataError
//                    return
//                }
//                do {
//                    self.currentUser = try JSONDecoder().decode(User.self, from: data)
//                    self.error = nil
//                } catch {
//                    self.error = NetworkError.serverError
//                }
//            case .failure(let error):
//                self.error = error
//            }
//        }

        currentUser = User(id: "1", userName: "user", email: "test@email.com", userType: .authUser)
    }
    
    @MainActor
    func sighUp(nickName: String, email: String, password: String) async {
        // сервер ещё в разработке
        let registerModel = Register(nickName: nickName, email: email, password: password)
        
        await networkService.post(urlString: ServerString.login.rawValue, 
                                  body: registerModel,
                                  method: .post) { (result: Result<Data?, NetworkError>) in
            switch result {
            case .success(let data):
                guard let data = data else {
                    self.error = NetworkError.dataError
                    return
                }
                do {
                    self.currentUser = try JSONDecoder().decode(User.self, from: data)
                    self.error = nil
                } catch {
                    self.error = NetworkError.serverError
                }
            case .failure(let error):
                self.error = error
            }
        }
        
        currentUser = User(id: "2", userName: nickName, email: email, userType: .authUser)
    }
    
    func skipAuth() {
        currentUser = User()
    }
    
    func signOut() {
        currentUser = nil
    }
}
