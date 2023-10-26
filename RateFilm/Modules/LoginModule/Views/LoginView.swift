//
//  LoginView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 07.10.2023.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    
    @State var showPassword = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Spacer(minLength: Consts.spacerPadding)
                Image("icon")
                    .resizable()
                    .frame(width: Consts.imageWidth, height: Consts.imageHeight)
                    .clipShape(Capsule())
                Spacer()
                EntryField(prompt: LoginViewEnum.loginPromptLabel.stringValue(), errorValidText: viewModel.loginError, field: $viewModel.login)
                EntryField(prompt: LoginViewEnum.passwordPromptLabel.stringValue(), errorValidText: viewModel.passwordError, isSecure: true, field: $viewModel.password)
                
                AuthorizationBlockButtons()
                CustomDivider()
                CustomButton(label: LoginViewEnum.signUpButtonLabel.stringValue()) {
                    
                }
                SkipAuthorizationButton()
                Spacer(minLength: Consts.spacerPadding)
            }
        }
    }
    
    private func CustomDivider() -> some View {
        HStack {
            Capsule()
                .frame(height: Consts.capsuleHeight)
            .padding(.horizontal)
            Text(LoginViewEnum.orLabel.stringValue())
                .foregroundStyle(Color.customLightGray)
            Capsule()
                .frame(height: Consts.capsuleHeight)
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
    
    private func AuthorizationBlockButtons() -> some View {
        HStack {
            Button {
                //
            } label: {
                Text(LoginViewEnum.forgotPasswordLabel.stringValue())
                    .foregroundStyle(Color.customLightGray)
            }
            Spacer()
            CustomButton(label: LoginViewEnum.signInButtonLabel.stringValue(), isMini: true, isFill: true) {
                viewModel.sighIn()
            }
            .opacity(viewModel.isSignInComplete ? 1 : 0.6)
            .disabled(!viewModel.isSignInComplete)
        }
        .padding(.horizontal)
    }
    
    private func SkipAuthorizationButton() -> some View {
        VStack(alignment: .center) {
            Button {
                //
            } label: {
                Text(LoginViewEnum.skipAuthLabel.stringValue())
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

enum LoginViewEnum {
    static var loginLabel: LocalizedStringKey = "loginLabel"
    static var passwordLabel: LocalizedStringKey = "passwordLabel"
    static var loginPromptLabel: LocalizedStringKey = "loginPromptLabel"
    static var passwordPromptLabel: LocalizedStringKey = "passwordPromptLabel"
    static var forgotPasswordLabel: LocalizedStringKey = "forgotPasswordLabel"
    static var signInButtonLabel: LocalizedStringKey = "signInButtonLabel"
    static var signUpButtonLabel: LocalizedStringKey = "signUpButtonLabel"
    static var orLabel: LocalizedStringKey = "orLabel"
    static var skipAuthLabel: LocalizedStringKey = "SkipAuthLabel"
}
