//
//  BlockingView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 25.11.2023.
//

import SwiftUI

struct BlockingView: View {
    @State var linkIsOn = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Text(LocalizedStrings.notWithUsYetLabel.localizeString())
                    .font(.system(size: 22))
                    .bold()
                    .foregroundStyle(Color.customBlack)
                Text(LocalizedStrings.authDecriptionLabel.localizeString())
                    .font(.system(size: 16))
                    .foregroundStyle(Color.customLightGray)
                    .multilineTextAlignment(.center)
                HStack {
                    Spacer(minLength: 100) //искусственно уменьшаю пространство, чтобы сработал нужный шаблон из ViewThatFits
                    NavigationLink(destination: LoginView(), isActive: $linkIsOn) {
                        CustomButton(label: LocalizedStrings.authorizationLabel.localizeString(), isMini: true) {
                            linkIsOn.toggle()
                        }
                    }
                    
                    Spacer(minLength: 100)
                }
            }
        }
    }
    
    enum LocalizedStrings: LocalizedStringKey {
        case authorizationLabel = "authorizationLabel"
        case notWithUsYetLabel = "notWithUsYetLabel"
        case authDecriptionLabel = "authDecriptionLabel"
        
        func localizeString() -> String {
            return NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
        }
    }
}

#Preview {
    BlockingView()
}
