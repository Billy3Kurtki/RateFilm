//
//  LoginView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 07.10.2023.
//

import SwiftUI

struct LoginView: View {
    @State var login: String = ""
    @State var password: String = ""
    @State var showPassword = false
    
    var body: some View {
        VStack(spacing: 10) {
            Image("icon")
                .resizable()
                .frame(width: Consts.imageWidth, height: Consts.imageHeight)
                .clipShape(Capsule())
            
            LoginTextField()
            
            ZStack {
                if showPassword {
                    PasswordField()
                } else {
                    PasswordSecureField()
                }
            }
            .overlay {
                ShowPasswordEyeButton()
            }
            
            AuthorizationBlockButtons()
            CustomDivider()
            RegisterButton()
        }
    }
    
    private func LoginTextField() -> some View {
        TextField("Login",
                  text: $login,
                  prompt: Text(LoginViewEnum.loginPromptLabel.localizeString())
            .foregroundColor(.customLightGray))
        .padding(10)
        .overlay {
            RoundedRectangle(cornerRadius: Consts.cornerRadius)
                .stroke(.black, lineWidth: Consts.lineWidth)
        }
        .padding(.horizontal)
    }
    
    private func PasswordField() -> some View {
        TextField("Password",
                  text: $password,
                  prompt: Text(LoginViewEnum.passwordPromptLabel.localizeString())
            .foregroundColor(.customLightGray))
        .padding(10)
        .overlay {
            RoundedRectangle(cornerRadius: Consts.cornerRadius)
                .stroke(.black, lineWidth: Consts.lineWidth)
        }
        .padding(.horizontal)
    }
    
    private func PasswordSecureField() -> some View {
        SecureField("Password",
                  text: $password,
                  prompt: Text(LoginViewEnum.passwordPromptLabel.localizeString())
            .foregroundColor(.customLightGray))
        .padding(11)
        .overlay {
            RoundedRectangle(cornerRadius: Consts.cornerRadius)
                .stroke(.black, lineWidth: Consts.lineWidth)
        }
        .padding(.horizontal)
    }
    
    private func ShowPasswordEyeButton() -> some View {
        HStack {
            Spacer()
            Button {
                showPassword.toggle()
            } label: {
                Image(systemName: showPassword ? "eye.slash" : "eye")
                    .foregroundStyle(.black)
            }
            .padding(.trailing, 25)
        }
    }
    
    private func RegisterButton() -> some View {
        Button {
            
        } label: {
            Text(LoginViewEnum.signUpButtonLabel.localizeString())
                .padding()
                .frame(width: Consts.buttonWidth * 2, height: Consts.buttonHeight)
                .foregroundStyle(Color.customLightGray)
                .overlay {
                    Capsule()
                        .stroke(Color.customLightGray, lineWidth: 2)
                }
        }
    }
    
    private func CustomDivider() -> some View {
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
    
    private func AuthorizationBlockButtons() -> some View {
        HStack {
            Button {
                //
            } label: {
                Text(LoginViewEnum.forgotPasswordLabel.localizeString())
                    .foregroundStyle(Color.customLightGray)
            }
            Spacer()
            
            Button {
                //
            } label: {
                Text(LoginViewEnum.signInButtonLabel.localizeString())
                    .padding(20)
                    .frame(width: Consts.buttonWidth, height: Consts.buttonHeight)
                    .background(.black)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                    
            }
        }
        .padding(.horizontal)
    }
    
    enum Consts {
        static var capsuleHeight: CGFloat = 2
        static var lineWidth: CGFloat = 2
        static var cornerRadius: CGFloat = 10
        static var imageWidth: CGFloat = 200
        static var imageHeight: CGFloat = 200
        static var buttonHeight: CGFloat = 50
        static var buttonWidth: CGFloat = 175
    }
}

#Preview {
    LoginView()
}

enum LoginViewEnum: String {
    case loginLabel = "loginLabel"
    case passwordLabel = "passwordLabel"
    case loginPromptLabel = "loginPromptLabel"
    case passwordPromptLabel = "passwordPromptLabel"
    case forgotPasswordLabel = "forgotPasswordLabel"
    case signInButtonLabel = "signInButtonLabel"
    case signUpButtonLabel = "signUpButtonLabel"
    case orLabel = "orLabel"
    
    func localizeString() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
