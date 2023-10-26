//
//  LoginViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 26.10.2023.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var login: String = ""
    @Published var password: String = ""
    
    func loginValid() -> Bool {
        if login.count > 0 {
            return true
        }
        return false
    }
    
    func passwordValid() -> Bool {
        if password.count > 0 {
            return true
        }
        return false
    }
    
    var isSignInComplete: Bool {
        if !loginValid() ||
           !passwordValid() {
            return false
        }
        return true
    }
    
    var loginError: String {
        if loginValid() {
            return ""
        }
        return InvalidLabels.loginValidError.localizeString()
    }
    
    var passwordError: String {
        if passwordValid() {
            return ""
        }
        return InvalidLabels.passwordValidError.localizeString()
    }
    func sighIn() {
        login = ""
        password = ""
    }
    
    enum InvalidLabels: String {
        case loginValidError = "LoginValidErrorLabel"
        case passwordValidError = "PasswordValidErrorLabel"
        
        func localizeString() -> String {
            return NSLocalizedString(self.rawValue, comment: "")
        }
    }
}
