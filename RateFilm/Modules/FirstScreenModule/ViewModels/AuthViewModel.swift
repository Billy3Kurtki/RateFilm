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

    var localizedError: String {
        switch error {
        case .invalidUrl:
            "" // пока так
        case .networkError:
            ""
        case .dataError:
            ""
        case .parseError:
            ""
        case .unexpectedResponse:
            ""
        case .failedResponse(let HTTPURLResponse):
            ""
        case .requestError:
            ""
        case .serverError:
            ""
        case nil:
            ""
        }
    }
    
    init(currentUser: User? = nil) {
        self.currentUser = currentUser
    }
    
    @MainActor
    func signInAsync(login: String, password: String) async {
        // сервер ещё в разработке
//        let loginModel = Login(userLogin: login, password: password)
//        
//        let result = await networkService.postAsync(urlString: ServerString.login.rawValue,
//                                                        body: loginModel,
//                                                        method: .post)
//        switch result {
//        case .success(let data):
//            guard let data = data else {
//                self.error = NetworkError.dataError
//                return
//            }
//            do {
//                self.currentUser = try JSONDecoder().decode(User.self, from: data)
//                self.error = nil
//            } catch {
//                self.error = NetworkError.parseError
//            }
//        case .failure(let error):
//            self.error = error
//        }

        currentUser = User(id: "1", userName: "user", email: "test@email.com", userType: .authUser)
    }
    
    @MainActor
    func sighUpAsync(nickName: String, email: String, password: String) async {
        // сервер ещё в разработке
//        let registerModel = Register(nickName: nickName, email: email, password: password)
//        
//        let result = await networkService.postAsync(urlString: ServerString.login.rawValue,
//                                                    body: registerModel,
//                                                    method: .post)
//        switch result {
//        case .success(let data):
//            guard let data = data else {
//                self.error = NetworkError.dataError
//                return
//            }
//            do {
//                self.currentUser = try JSONDecoder().decode(User.self, from: data)
//                self.error = nil
//            } catch {
//                self.error = NetworkError.parseError
//            }
//        case .failure(let error):
//            self.error = error
//        }

        currentUser = User(id: "2", userName: nickName, email: email, userType: .authUser)
    }
    
    func changePasswordAsync(login: String, password: String) async {
        let loginModel = Login(userLogin: login, password: password)
        
        let result = await networkService.postAsync(urlString: ServerString.changePassword.rawValue,
                                                        body: loginModel,
                                                        method: .put)
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
                self.error = NetworkError.parseError
            }
        case .failure(let error):
            self.error = error
        }
    }
    
    func skipAuth() {
        currentUser = User()
    }
    
    func signOut() {
        currentUser = nil
    }
}
