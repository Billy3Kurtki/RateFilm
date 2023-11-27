//
//  ForgotPasswordViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 16.11.2023.
//

import SwiftUI
import Observation

@Observable
final class ForgotPasswordViewModel {
    var login: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    
    var loginError: String = ""
    var passwordError: String = ""
    var confirmPasswordError: String = ""
    
    
    func loginValid() -> Bool {
        if Range(5...20).contains(login.count) {
            loginError = ""
            return true
        }
        loginError = InvalidLabels.loginInvalidLabel.localizeString()
        return false
    }
    
    func isPasswordValid() -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", Regex.password.rawValue)
        if passwordTest.evaluate(with: password) {
            passwordError = ""
            return true
        }
        passwordError = InvalidLabels.passwordInvalidLabel.localizeString()
        return false
    }
    
    func passwordsMatch() -> Bool {
        if password == confirmPassword {
            confirmPasswordError = ""
            return true
        }
        confirmPasswordError = InvalidLabels.confirmPasswordInvalidLabel.localizeString()
        return false
    }
    
    var isNewPasswordComplete: Bool {
        let loginValidation = loginValid()
        let isPasswordValidation = isPasswordValid()
        let passwordsMatchValidation = passwordsMatch()
        if !loginValidation ||
           !isPasswordValidation ||
           !passwordsMatchValidation {
            return false
        }
        return true
    }
    
    enum InvalidLabels: LocalizedStringKey {
        case loginInvalidLabel = "LoginValidErrorLabel"
        case passwordInvalidLabel = "PasswordInvalidLabel"
        case confirmPasswordInvalidLabel = "ConfirmPasswordInvalidLabel"
        
        func localizeString() -> String {
            NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
        }
    }
}
