//
//  RegisterView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 06.10.2023.
//

import SwiftUI

struct RegisterView: View {
    @Bindable var viewModel = RegisterViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                EntryField(prompt: RegisterViewEnum.nicknameLabel.stringValue(), errorValidText: viewModel.nicknameError, field: $viewModel.nickname)
                EntryField(prompt: RegisterViewEnum.emailLabel.stringValue(), errorValidText: viewModel.emailError, field: $viewModel.email)
                EntryField(prompt: RegisterViewEnum.passwordPromptLabel.stringValue(), errorValidText: viewModel.passwordError, isSecure: true, field: $viewModel.password)
                EntryField(prompt: RegisterViewEnum.repeatPasswordLabel.stringValue(), errorValidText: viewModel.confirmPasswordError, isSecure: true, field: $viewModel.confirmPassword)
                CustomButton(label: RegisterViewEnum.createProfileLabel.stringValue(), isFill: true, action: {
                    viewModel.signUp()
                })
                .padding(.vertical, 10)
                .opacity(viewModel.isSignUpComplete ? 1 : 0.65)
                .disabled(!viewModel.isSignUpComplete)
            }
            .padding(.vertical)
            .navigationTitle("Создание профиля")
        }
    }
}

enum RegisterViewEnum {
    static var nicknameLabel: LocalizedStringKey = "NicknameLabel"
    static var emailLabel: LocalizedStringKey = "EmailLabel"
    static var passwordLabel: LocalizedStringKey = "passwordLabel"
    static var passwordPromptLabel: LocalizedStringKey = "passwordPromptLabel"
    static var repeatPasswordLabel: LocalizedStringKey = "RepeatPasswordLabel"
    static var createProfileLabel: LocalizedStringKey = "CreateProfileLabel"
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
    
    // MARK: Функция для адаптивной ширины кнопки в зависимости от ширины окна приложения. Мини-версия - это уменьшенная вдвое относительно большой-версии (+- 350px) до +- 175px.
    func buttonWidth() -> CGFloat {
        let spacing: CGFloat = Consts.spacing
        let totalSpacing: CGFloat = 2 * spacing
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first
        else { return 0 }
        
        let screenWidth = window.frame.width
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
