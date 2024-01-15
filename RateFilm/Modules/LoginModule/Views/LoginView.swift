//
//  LoginView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 07.10.2023.
//

import SwiftUI

struct LoginView: View {
    @Bindable var viewModel = LoginViewModel()
    @Environment(AuthViewModel.self) private var authVM
    @State private var showPassword = false
    @State private var linkToRegisterViewIsActive = false
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Spacer(minLength: Consts.spacerPadding)
                Image(AppConsts.appIcon)
                    .resizable()
                    .frame(width: Consts.imageWidth, height: Consts.imageHeight)
                    .clipShape(Capsule())
                Spacer()
                EntryField(prompt: LoginViewEnum.loginPromptLabel.localizeString(), errorValidText: viewModel.loginError, field: $viewModel.login)
                EntryField(prompt: LoginViewEnum.passwordPromptLabel.localizeString(), errorValidText: viewModel.passwordError, isSecure: true, field: $viewModel.password)
                
                authorizationBlockButtons()
                customDivider()
                NavigationLink(destination: RegisterView(), isActive: $linkToRegisterViewIsActive) {
                    CustomButton(label: LoginViewEnum.signUpButtonLabel.localizeString()) {
                        linkToRegisterViewIsActive.toggle()
                    }
                }
                
                skipAuthorizationButton()
                Spacer(minLength: Consts.spacerPadding)
            }
            .overlay {
                if authVM.state == .loading {
                    ProgressView()
                }
            }
        }
        .onAppear {
            authVM.currentUser = nil
        }
    }
    
    private func customDivider() -> some View {
        HStack {
            Capsule()
                .frame(height: Consts.capsuleHeight)
                .padding(.horizontal)
            Text(LoginViewEnum.orLabel.localizeString())
                .foregroundStyle(Color.customLightGray)
            Capsule()
                .frame(height: Consts.capsuleHeight)
                .padding(.horizontal)
        }
        .padding(.vertical)
    }
    
    private func authorizationBlockButtons() -> some View {
        HStack {
            NavigationLink(destination: ForgotPasswordView()) {
                Text(LoginViewEnum.forgotPasswordLabel.localizeString())
                    .foregroundStyle(Color.customLightGray)
            }
            Spacer()
            CustomButton(label: LoginViewEnum.signInButtonLabel.localizeString(), isMini: true, isFill: true) {
                if viewModel.isSignInComplete {
                    Task {
                        await authVM.signInAsync(login: viewModel.login, password: viewModel.password)
                    }
                }
            }
        }
        .padding(.leading, 20)
    }
    
    private func skipAuthorizationButton() -> some View {
        VStack(alignment: .center) {
            Button {
                authVM.skipAuth()
            } label: {
                Text(LoginViewEnum.skipAuthLabel.localizeString())
                    .foregroundStyle(Color.customLightGray)
            }
        }.padding()
    }
    
    enum Consts {
        static var capsuleHeight: CGFloat = 2
        static var lineWidth: CGFloat = 2
        static var cornerRadius: CGFloat = 10
        static var imageWidth: CGFloat = 200
        static var imageHeight: CGFloat = 200
        static var buttonHeight: CGFloat = 50
        static var buttonWidth: CGFloat = 175
        static var spacerPadding: CGFloat = 100
    }
}

#Preview {
    LoginView()
}

enum LoginViewEnum: LocalizedStringKey {
    case loginLabel = "loginLabel"
    case passwordLabel = "passwordLabel"
    case loginPromptLabel = "loginPromptLabel"
    case passwordPromptLabel = "passwordPromptLabel"
    case forgotPasswordLabel = "forgotPasswordLabel"
    case signInButtonLabel = "signInButtonLabel"
    case signUpButtonLabel = "signUpButtonLabel"
    case orLabel = "orLabel"
    case skipAuthLabel = "SkipAuthLabel"
    
    func localizeString() -> String {
        NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
    }
}
