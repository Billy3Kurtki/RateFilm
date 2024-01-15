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
    var state: LoadStates = .didLoad
    
    init(currentUser: User? = nil) {
        self.currentUser = currentUser
    }
    
    @MainActor
    func signInAsync(login: String, password: String) async {
        state = .loading
        let loginModel = Login(userLogin: login, password: password)
        
        let result = await networkService.postAsync(urlString: ServerString.login,
                                                        body: loginModel,
                                                        method: .post)
        switch result {
        case .success(let data):
            guard let data = data else {
                self.error = NetworkError.dataError
                return
            }
            do {
                let networkUser = try JSONDecoder().decode(NetworkUser.self, from: data)
                self.currentUser = CustomFormatter.convertNetworkUserToUser(networkUser)
                self.error = nil
            } catch {
                self.error = NetworkError.parseError
            }
        case .failure(let error):
            self.error = error
        }
        state = .didLoad
    }
    
    @MainActor
    func sighUpAsync(nickName: String, email: String, password: String) async {
        state = .loading
        let registerModel = Register(userName: nickName, email: email, password: password)
        
        let result = await networkService.postAsync(urlString: ServerString.register,
                                                    body: registerModel,
                                                    method: .post)
        switch result {
        case .success(let data):
            guard let data = data else {
                self.error = NetworkError.dataError
                print("\(String(describing: self.error))")
                return
            }
            do {
                let networkUser = try JSONDecoder().decode(NetworkUser.self, from: data)
                self.currentUser = CustomFormatter.convertNetworkUserToUser(networkUser)
                print("\(String(describing: self.error))")
                self.error = nil
            } catch {
                self.error = NetworkError.parseError
                print("\(String(describing: self.error))")
            }
        case .failure(let error):
            self.error = error
            print("\(String(describing: self.error))")
        }
        state = .didLoad
    }
    
    func changePasswordAsync(login: String, password: String) async {
        let loginModel = Login(userLogin: login, password: password)
        
        let result = await networkService.postAsync(urlString: ServerString.changePassword,
                                                        body: loginModel,
                                                        method: .put)
        switch result {
        case .success(let data):
            guard let data = data else {
                self.error = NetworkError.dataError
                print("\(String(describing: self.error))")
                return
            }
            do {
                let networkUser = try JSONDecoder().decode(NetworkUser.self, from: data)
                self.currentUser = CustomFormatter.convertNetworkUserToUser(networkUser)
                print("\(String(describing: self.error))")
                self.error = nil
            } catch {
                self.error = NetworkError.parseError
                print("\(String(describing: self.error))")
            }
        case .failure(let error):
            self.error = error
            print("\(String(describing: self.error))")
        }
    }
    
    func skipAuth() {
        currentUser = User()
    }
    
    func signOut() {
        currentUser = nil
    }
}
