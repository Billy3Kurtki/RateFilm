//
//  SearchView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 10.11.2023.
//

import SwiftUI

struct CustomSearchView: View {
    @Binding var searchText: String
    var focus: FocusState<FocusElement?>.Binding
    var prompt: String
    
    var body: some View {
        ZStack(alignment: .trailing) {
            ZStack {
                RoundedRectangle(cornerRadius: Consts.cornerRadius, style: .continuous)
                    .stroke(lineWidth: Consts.lineWidth)
                    .foregroundStyle(Color.accentColor)
                TextField(prompt, text: $searchText)
                    .padding(.horizontal)
                    .foregroundStyle(Color.customBlack)
                    .focused(focus, equals: .movie)
            }
            .frame(width: Consts.width, height: Consts.height)
            .foregroundStyle(Color.customWhite)
            
            Image(systemName: Consts.imageName)
                .foregroundStyle(Color.customBlack)
                .bold()
                .offset(x: Consts.offsetX, y: Consts.offsetY)
        }
    }
    
    enum Consts {
        static var width: CGFloat = 350
        static var height: CGFloat = 40
        static var cornerRadius: CGFloat = 40
        static var lineWidth: CGFloat = 3
        static var offsetX: CGFloat = -7
        static var offsetY: CGFloat = -1
        static var imageName: String = "magnifyingglass"
    }
}

enum FocusElement: Hashable {
    case movie
    case favoriteMovie
}

struct NavBarMainView: View {
    @Binding var searchText: String
    var focus: FocusState<FocusElement?>.Binding
    var prompt: String
    
    var body: some View {
        NavigationStack {
            HStack {
                CustomSearchView(searchText: $searchText, focus: focus, prompt: prompt)
                SettingsButton()
            }
        }
    }
    
    private func SettingsButton() -> some View {
        NavigationLink(destination: SettingsView()) {
            Image(systemName: "gearshape")
                .resizable()
                .frame(width: 21, height: 21)
                .foregroundStyle(Color.customBlack)
                .bold()
        }
    }
}

//#Preview {
//    NavBarMainView(searchText: .constant(""), prompt: "Search")
//}
