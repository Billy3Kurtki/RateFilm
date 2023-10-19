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
                    ForEach(Selections.allCases, id: \.self) { selection in
                        Button {
                            self.selectedCategory = selection.rawValue
                            withAnimation(.easeInOut(duration: 20)) {
                                scrollProxy.scrollTo(selection, anchor: .center)
                            }
                        } label: {
                            VStack {
                                Text(selection.rawValue)
                                    .padding()
                                    .foregroundStyle(self.selectedCategory == selection.rawValue ? Color.red : Color.black)
                                    .font(.system(size: 19))
                                Capsule()
                                    .foregroundStyle(self.selectedCategory == selection.rawValue ? Color.red : Color.clear)
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

enum Selections: String, CaseIterable {
    case mySelection = "Моя вкладка"
    case lastReleased = "Последнее"
    case ongoings = "Онгоинги"
    case announcement = "Анонсы"
    case films = "Фильмы"
    case serials = "Сериалы"
}
