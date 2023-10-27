//
//  LoginViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 26.10.2023.
//

import SwiftUI
import Observation

@Observable
class LoginViewModel: ObservableObject {
    var login: String = ""
    var password: String = ""
    
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
    
    enum InvalidLabels: LocalizedStringKey {
        case loginValidError = "LoginValidErrorLabel"
        case passwordValidError = "PasswordValidErrorLabel"
        
        func localizeString() -> String {
            NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
        }
    }
}
