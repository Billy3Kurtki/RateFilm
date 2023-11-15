//
//  RegisterViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 26.10.2023.
//

import SwiftUI
import Observation

@Observable
class RegisterViewModel: ObservableObject {
    var nickname: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    
    func nicknameValid() -> Bool {
        if Range(5...20).contains(nickname.count) {
            return true
        }
        return false
    }
    
    func passwordsMatch() -> Bool { password == confirmPassword }
    
    func isPasswordValid() -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", Regex.password.rawValue)
        return passwordTest.evaluate(with: password)
    }
    
    func isEmailValid() -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", Regex.email.rawValue)
        return emailTest.evaluate(with: email)
    }
    
    var isSignUpComplete: Bool {
        if !nicknameValid() ||
           !passwordsMatch() ||
           !isPasswordValid() ||
           !isEmailValid() {
            return false
        }
        return true
    }
    
    var nicknameError: String {
        if nicknameValid() {
            return ""
        }
        return InvalidLabels.nicknameInvalidLabel.localizeString()
    }
    
    var confirmPasswordError: String {
        if passwordsMatch() {
            return ""
        }
        return InvalidLabels.confirmPasswordInvalidLabel.localizeString()
    }
    
    var emailError: String {
        if isEmailValid() {
            return ""
        }
        return InvalidLabels.emailInvalidLabel.localizeString()
    }
    
    var passwordError: String {
        if isPasswordValid() {
            return ""
        }
        return InvalidLabels.passwordInvalidLabel.localizeString()
    }
    
    enum InvalidLabels: LocalizedStringKey {
        case confirmPasswordInvalidLabel = "ConfirmPasswordInvalidLabel"
        case emailInvalidLabel = "EmailInvalidLabel"
        case passwordInvalidLabel = "PasswordInvalidLabel"
        case nicknameInvalidLabel = "NicknameInvalidLabel"
        
        func localizeString() -> String {
            NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
        }
    }
}

enum Regex: String {
    case email = "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$"
    case password = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$"
}
