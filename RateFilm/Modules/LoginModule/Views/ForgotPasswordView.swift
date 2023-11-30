//
//  ForgotPassword.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 16.11.2023.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Bindable var viewModel = ForgotPasswordViewModel()
    @Environment(AuthViewModel.self) private var authVM
    
    var body: some View {
        NavigationStack {
            VStack {
                EntryField(prompt: ForgotPasswordEnum.login.localizeString(), errorValidText: viewModel.loginError, field: $viewModel.login)
                EntryField(prompt: ForgotPasswordEnum.password.localizeString(), errorValidText: viewModel.passwordError, isSecure: true, field: $viewModel.password)
                EntryField(prompt: ForgotPasswordEnum.repeatPassword.localizeString(), errorValidText: viewModel.confirmPasswordError, isSecure: true, field: $viewModel.confirmPassword)
                CustomButton(label: ForgotPasswordEnum.continueLabel.localizeString(), isFill: true) {
                    if viewModel.isNewPasswordComplete {
//                        Task {
//                            await authVM.changePasswordAsync(login: viewModel.login, password: viewModel.password)
//                        }
                    }
                }
                .padding(.vertical, 10)
            }
            .navigationTitle(ForgotPasswordEnum.passwordRecovery.localizeString())
        }
    }
}

enum ForgotPasswordEnum: LocalizedStringKey {
    case login = "loginPromptLabel"
    case password = "passwordPromptLabel"
    case repeatPassword = "RepeatPasswordLabel"
    case continueLabel = "continueLabel"
    case passwordRecovery = "passwordRecoveryLabel"
    
    func localizeString() -> String {
        NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
    }
}

#Preview {
    ForgotPasswordView()
}
