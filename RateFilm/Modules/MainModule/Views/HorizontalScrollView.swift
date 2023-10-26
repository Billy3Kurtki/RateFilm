//
//  HorizontalScrollView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 10.10.2023.
//

import SwiftUI

struct HorizontalScrollView: View {
    @Binding var selectedCategory: String
    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer(minLength: 20)
                    ForEach(MainViewSelections.allCases, id: \.self) { selection in
                        Button {
                            self.selectedCategory = selection.localizeString()
                            withAnimation(.easeInOut(duration: 20)) {
                                scrollProxy.scrollTo(selection, anchor: .center)
                            }
                        } label: {
                            VStack {
                                Text(selection.localizeString())
                                    .padding()
                                    .foregroundStyle(self.selectedCategory == selection.localizeString() ? Color.customLightRed : Color.customBlack)
                                    .font(.system(size: 19))
                                Capsule()
                                    .foregroundStyle(self.selectedCategory == selection.localizeString() ? Color.customLightRed : Color.clear)
                                    .frame(height: 4)
                                
                            }.fixedSize()
                        }
                    }
                }.padding()
            }
        }
    }
}

//#Preview {
//    HorizontalScrollView()
//}

enum MainViewSelections: String, CaseIterable { // через static var ... : LocalizedStringKey не получится, тк нужно, чтобы осталось соответствие CaseIterable
    case mySelection = "mySelection"
    case lastReleased = "lastReleased"
    case ongoings = "ongoings"
    case announcement = "announcement"
    case films = "films"
    case serials = "serials"
    
    func localizeString() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
