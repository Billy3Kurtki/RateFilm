//
//  ErrorView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 20.12.2023.
//

import SwiftUI

struct ErrorView: View {
    var action: () -> ()
    
    var body: some View {
        VStack {
            Text(LocalizedStrings.oopsWhatsWrong.localizeString())
                .font(.system(size: Consts.titleFontSize).bold())
                .foregroundStyle(Color.customBlack)
            Text(LocalizedStrings.gotLoadError.localizeString())
                .font(.system(size: Consts.textFontSize))
                .foregroundStyle(Color.customLightGray)
            Button {
                action()
            } label: {
                ZStack {
                    Capsule()
                        .stroke(lineWidth: Consts.capsuleStroke)
                        .foregroundStyle(Color.customGray)
                    Text(LocalizedStrings.retry.localizeString())
                        .font(.system(size: Consts.textFontSize).bold())
                        .foregroundStyle(Color.customBlack)
                }
                .frame(width: Consts.buttonWidth, height: Consts.buttonHeight)
            }
        }
    }
    
    enum LocalizedStrings: LocalizedStringKey {
        case oopsWhatsWrong = "OopsWhatsWrongLabel"
        case gotLoadError = "gotLoadErrorLabel"
        case retry = "retryLabel"
        
        func localizeString() -> String {
            return NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
        }
    }
    
    enum Consts {
        static var titleFontSize: CGFloat = 22
        static var textFontSize: CGFloat = 17
        static var buttonWidth: CGFloat = 140
        static var buttonHeight: CGFloat = 45
        static var capsuleStroke: CGFloat = 1.0
        
    }
}

#Preview {
    ErrorView(action: {})
}
