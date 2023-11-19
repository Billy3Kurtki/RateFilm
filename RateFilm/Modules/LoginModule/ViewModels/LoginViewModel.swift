//
//  LoginViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 26.10.2023.
//

import SwiftUI
import Observation

@Observable
final class LoginViewModel: ObservableObject {
    var login: String = ""
    var password: String = ""
    
    
    var loginError: String = ""
    var passwordError: String = ""
    
    func loginValid() -> Bool {
        if login.count > 0 {
            loginError = ""
            return true
        }
        loginError = InvalidLabels.loginValidError.localizeString()
        return false
    }
    
    func passwordValid() -> Bool {
        if password.count > 0 {
            passwordError = ""
            return true
        }
        passwordError = InvalidLabels.passwordValidError.localizeString()
        return false
    }
    
    var isSignInComplete: Bool {
        var loginValidation = loginValid()
        var passwordValidation = passwordValid()
        if !loginValidation ||
           !passwordValidation {
            return false
        }
        return true
    }
    
    enum InvalidLabels: LocalizedStringKey {
        case loginValidError = "LoginValidErrorLabel"
        case passwordValidError = "PasswordValidErrorLabel"
        
        func localizeString() -> String {
            NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
        }
    }
}
