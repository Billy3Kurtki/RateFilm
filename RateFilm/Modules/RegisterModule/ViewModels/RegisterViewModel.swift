//
//  RegisterViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 26.10.2023.
//

import SwiftUI
import Observation

@Observable
final class RegisterViewModel: ObservableObject {
    var nickname: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    
    
    var nicknameError: String = ""

    var confirmPasswordError: String = ""

    var emailError: String = ""

    var passwordError: String = ""
    
    func nicknameValid() -> Bool {
        if Range(5...20).contains(nickname.count) {
            nicknameError = ""
            return true
        }
        nicknameError = InvalidLabels.nicknameInvalidLabel.localizeString()
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
    
    func isPasswordValid() -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", Regex.password.rawValue)
        if passwordTest.evaluate(with: password) {
            passwordError = ""
            return true
        }
        passwordError = InvalidLabels.passwordInvalidLabel.localizeString()
        return false
    }
    
    func isEmailValid() -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", Regex.email.rawValue)
        if emailTest.evaluate(with: email) {
            emailError = ""
            return true
        }
        emailError = InvalidLabels.emailInvalidLabel.localizeString()
        return false
    }
    
    var isSignUpComplete: Bool {
        var nicknameValidation = nicknameValid() // реализовано так, потому что, если оставить, как было, то если, например, неверно указан никнейм, то условие сразу обрубало валидацию других полей. А здесь, валидация сразу по всем полям, и только потом проверка.
        var isEmailValidation = isEmailValid()
        var isPasswordValidation = isPasswordValid()
        var passwordsMatchValidation = passwordsMatch()
        if !nicknameValidation ||
           !isEmailValidation ||
           !isPasswordValidation ||
           !passwordsMatchValidation {
            return false
        }
        return true
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
