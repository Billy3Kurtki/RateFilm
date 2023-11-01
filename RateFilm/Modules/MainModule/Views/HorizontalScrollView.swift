//
//  HorizontalScrollView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 10.10.2023.
//

import SwiftUI

struct HorizontalScrollView: View {
    @Binding var selectedCategory: MainViewSelections
    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer(minLength: 20)
                    ForEach(MainViewSelections.allCases, id: \.self) { selection in
                        Button {
                            self.selectedCategory = selection
                            withAnimation(.easeInOut(duration: 20)) {
                                scrollProxy.scrollTo(selection, anchor: .center)
                            }
                        } label: {
                            Text(selection.localizeString())
                                .padding()
                                .foregroundStyle(self.selectedCategory == selection ? Color.customLightRed : Color.customBlack)
                                .font(.system(size: 19))
                                .background(
                                    Capsule()
                                        .foregroundStyle(self.selectedCategory == selection ? Color.customLightRed : Color.clear)
                                        .frame(height: 3)
                                        .offset(y: 22)
                                )
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

