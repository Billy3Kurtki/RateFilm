//
//  ListView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 11.10.2023.
//

import SwiftUI

struct ListView: View {
    @State private var search = ""
    @StateObject private var data = ListViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(data.filmsVM) { film in
                    NavigationLink(destination: MovieDetailsView()) {
                        FilmCell(film: film)
                    }
                }
            }
        }
        .padding(.vertical, 20)
    }
}

struct FilmCell: View {
    var film: FilmViewModel
    
    var body: some View {
        HStack {
            AsyncIconRowView(urlString: film.previewImage)
            
            DescriptionView(name: film.name, description: film.description, realeseDate: film.releaseDate, avgRating: film.avgRating)
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct AsyncIconRowView: View {
    var urlString: String
    var body: some View {
        AsyncImage(url: URL(string: urlString)) { data in
            if let image = data.image {
                image
                    .imageIconModifier(width: Consts.iconWidth, height: Consts.iconHeight)
                    
            } else if data.error != nil {
                Image(uiImage: UIImage(named: "defaultImage")!)
                    .imageIconModifier(width: Consts.iconWidth, height: Consts.iconHeight)
            } else {
                ZStack { // пока плохо. Надо заменить.
                    RoundedRectangle(cornerSize: CGSize(width: 1, height: 1))
                        .opacity(0)
                    ProgressView()
                }
            }
        }
    }
    
    enum Consts {
        static var iconWidth: CGFloat = 100
        static var iconHeight: CGFloat = 150
    }
}


struct DescriptionView: View {
    var name, description: String
    var episodesCount, realeseDate, avgRating: String?
    var body: some View {
        VStack(alignment: .leading) {
            Spacer(minLength: 5)
            Text(name)
                .foregroundStyle(.black)
                .font(.system(size: Consts.textTitleSize))
                .bold()
            if let avgRating = avgRating {
                HStack {
                    Text(avgRating)
                        .font(.system(size: Consts.textSize))
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: Consts.iconStarWidth, height: Consts.iconStarHeight)
                }
                .foregroundStyle(Color.customLightGray)
            }
            if let realeseDate = realeseDate {
                Text(realeseDate)
                    .foregroundStyle(Color.customLightGray)
                    .padding(5)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(Color("superLightGray"))
                    }
            }
            
            Text(description)
                .foregroundStyle(Color.customGray)
                .font(.system(size: Consts.textSize))
                .frame(maxHeight: Consts.maxTextHeight)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .padding()
        .frame(height: 200)
    }
    
    enum Consts {
        static var maxTextHeight: CGFloat = 80
        static var textSize: CGFloat = 20
        static var textTitleSize: CGFloat = 22
        static var iconStarWidth: CGFloat = 18
        static var iconStarHeight: CGFloat = 18
    }
}

#Preview {
    ListView()
}
