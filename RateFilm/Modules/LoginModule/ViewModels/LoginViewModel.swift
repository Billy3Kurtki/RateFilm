//
//  LoginViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 26.10.2023.
//

import SwiftUI

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
        return InvalidLabels.loginValidError.stringValue()
    }
    
    var passwordError: String {
        if passwordValid() {
            return ""
        }
        return InvalidLabels.passwordValidError.stringValue()
    }
    func sighIn() {
        login = ""
        password = ""
    }
    
    enum InvalidLabels {
        static var loginValidError: LocalizedStringKey = "LoginValidErrorLabel"
        static var passwordValidError: LocalizedStringKey = "PasswordValidErrorLabel"
    }
}
