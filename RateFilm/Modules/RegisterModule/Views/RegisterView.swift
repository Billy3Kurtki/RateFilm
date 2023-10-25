//
//  RegisterView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 06.10.2023.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel = RegisterViewModel()
    var body: some View {
        VStack {
            EntryField(prompt: RegisterViewEnum.nicknameLabel.localizeString(), errorValidText: viewModel.nicknameError, field: $viewModel.nickname)
            EntryField(prompt: RegisterViewEnum.emailLabel.localizeString(), errorValidText: viewModel.emailError, field: $viewModel.email)
            EntryField(prompt: RegisterViewEnum.passwordPromptLabel.localizeString(), errorValidText: viewModel.passwordError, isSecure: true, field: $viewModel.password)
            EntryField(prompt: RegisterViewEnum.repeatPasswordLabel.localizeString(), errorValidText: viewModel.confirmPasswordError, isSecure: true, field: $viewModel.confirmPassword)
            CustomButton(label: RegisterViewEnum.createProfileLabel.localizeString(), isFill: true, action: {
                viewModel.signUp()
            })
            .padding(.vertical, 10)
            .opacity(viewModel.isSignUpComplete ? 1 : 0.65)
            .disabled(!viewModel.isSignUpComplete)
        }
        .padding(.vertical)
    }
}

enum RegisterViewEnum: String {
    case nicknameLabel = "NicknameLabel"
    case emailLabel = "EmailLabel"
    case passwordLabel = "passwordLabel"
    case passwordPromptLabel = "passwordPromptLabel"
    case repeatPasswordLabel = "RepeatPasswordLabel"
    case createProfileLabel = "CreateProfileLabel"
    
    func localizeString() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

struct EntryField: View {
    var prompt: String
    var errorValidText: String
    var isSecure: Bool = false
    @Binding var field: String
    
    var body: some View {
        if isSecure {
            CustomSecureField(field: $field, prompt: prompt)
        } else {
            CustomTextField(field: $field, prompt: prompt)
        }
        
        HStack {
            Spacer()
            Text(errorValidText)
                .padding(.horizontal)
                .fixedSize(horizontal: false, vertical: true)
                .font(.caption)
        }
    }
    
    struct CustomTextField: View {
        @Binding var field: String
        var prompt: String
        var body: some View {
            TextField("Entry", text: $field, prompt: Text(prompt)
                .foregroundColor(.customLightGray))
            .padding(10)
            .modifier(FieldModifier())
        }
    }
    
    struct CustomSecureField: View {
        @Binding var field: String
        var prompt: String
        @State var showPassword: Bool = false
        
        var body: some View {
            ZStack {
                if showPassword {
                    CustomTextField(field: $field, prompt: prompt)
                } else {
                    SecureField("Entry", text: $field, prompt: Text(prompt)
                        .foregroundColor(.customLightGray))
                    .padding(11)
                    .modifier(FieldModifier())
                }
                HStack {
                    Spacer()
                    Button {
                        showPassword.toggle()
                    } label: {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundStyle(Color.customBlack)
                    }
                    .padding(.trailing, 25)
                }
            }
        }
    }
    
    struct FieldModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .overlay {
                    RoundedRectangle(cornerRadius: Consts.cornerRadius)
                        .stroke(Color.customBlack, lineWidth: Consts.lineWidth)
                }
                .padding(.horizontal)
        }
        
        enum Consts {
            static var lineWidth: CGFloat = 2
            static var cornerRadius: CGFloat = 10
        }
    }
}

struct CustomButton: View {
    var label: String
    var isMini: Bool = false
    var isFill: Bool = false
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .padding()
                .frame(width: buttonWidth(), height: Consts.buttonHeight)
                .modifier(ButtonModifier(isFill: isFill))
        }
    }
    
    // MARK: Функция для адаптивной ширины кнопки в зависимости от ширины экрана. Мини-версия - это уменьшенная вдвое относительно большой-версии (+- 350px) до +- 175px.
    func buttonWidth() -> CGFloat {
        let spacing: CGFloat = Consts.spacing
        let totalSpacing: CGFloat = 2 * spacing
        let screenWidth = UIScreen.main.bounds.width
        if isMini {
            return (screenWidth - totalSpacing) / 2
        }
        return screenWidth - totalSpacing
    }
    
    struct ButtonModifier: ViewModifier {
        var isFill: Bool
        func body(content: Content) -> some View {
            if isFill {
                content
                    .background(Color.customBlack)
                    .foregroundStyle(Color.customWhite)
                    .clipShape(Capsule())
            } else {
                content
                    .foregroundStyle(Color.customBlack)
                    .overlay {
                        Capsule()
                            .stroke(Color.customBlack, lineWidth: 2)
                    }
            }
        }
    }
    
    enum Consts {
        static var buttonHeight: CGFloat = 50
        static var spacing: CGFloat = 15
    }
}



#Preview {
    RegisterView()
}
