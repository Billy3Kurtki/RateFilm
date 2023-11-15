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
    
    init(currentUser: User? = nil) {
        self.currentUser = currentUser
    }
    
    func signIn(login: String, password: String) async {
        // networking
        
        currentUser = User(id: "1", userName: "user", email: "test@email.com", userType: .authUser)
    }
    
    func sighUp(nickName: String, email: String, password: String) async {
        // networking
        
        currentUser = User(id: "2", userName: nickName, email: email, userType: .authUser)
    }
    
    func skipAuth() {
        currentUser = User(id: "###", userName: "unauthorizrdUser", email: "test@email.com", userType: .unauthUser)
    }
    
    func signOut() {
        currentUser = nil
    }
    //.....
}
