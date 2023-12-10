//
//  ListView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 11.10.2023.
//

import SwiftUI

struct ListView: View {
    var snippets: [SnippetViewModel]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(snippets) { snippet in
                    NavigationLink(destination: MovieDetailsView()) {
                        SnippetCell(snippet: snippet)
                    }
                }
            }
        }
        .padding(.vertical, 20)
    }
}

struct SnippetCell: View {
    var snippet: SnippetViewModel
    
    var body: some View {
        HStack {
            AsyncIconRowView(urlString: snippet.previewImage, favoriteSelection: snippet.movieStatus)
            
            DescriptionView(name: snippet.name, description: snippet.description, seriesCount: snippet.seriesCount, realeseDate: snippet.releaseDate, avgRating: snippet.avgRating, isFavorite: snippet.isFavorite)
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct AsyncIconRowView: View {
    var urlString: String
    var favoriteSelection: MovieStatus
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: urlString)) { data in
                if let image = data.image {
                    image
                        .imageIconModifier()
                } else if data.error != nil {
                    Consts.defaultImage
                        .imageIconModifier()
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: Consts.cornerRadius)
                            .foregroundStyle(Color.customLightGray)
                        ProgressView()
                    }
                }
            }
            if favoriteSelection != .none {
                movieStatusView()
            }
        }
        .frame(width: Consts.iconWidth, height: Consts.iconHeight)
        .clipShape(RoundedRectangle(cornerRadius: Consts.cornerRadius))
    }
    
    var favoriteColor: Color {
        switch favoriteSelection {
        case .none:
            return .clear
        case .looking:
            return .green
        case .inThePlans:
            return .pink
        case .viewed:
            return .purple
        case .postponed:
            return .orange
        case .abandoned:
            return .red
        }
    }
    
    private func movieStatusView() -> some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .frame(height: 20)
                    .foregroundStyle(favoriteColor)
                    .opacity(Consts.opacity)
                Text(favoriteSelection.localizeString())
                    .font(.system(size: 12))
                    .foregroundStyle(Color.white)
            }
        }
        
    }
    
    enum Consts {
        static var iconWidth: CGFloat = 100
        static var iconHeight: CGFloat = 150
        static var defaultImage: Image = Image(uiImage: UIImage(named: "defaultImage")!)
        static var cornerRadius: CGFloat = 6
        static var opacity: Double = 0.8
    }
}


struct DescriptionView: View {
    var name, description: String
    var seriesCount, realeseDate, avgRating: String?
    var isFavorite: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer(minLength: 5)
            titleView()
            HStack {
                if let _ = seriesCount {
                    seriesCountView()
                }
                if let _ = avgRating {
                    avgRatingView()
                }
                if isFavorite {
                    favoriteImageView()
                }
            }
            if let _ = realeseDate {
                realeseDateView()
            }
            
            descriptionView()
            Spacer()
        }
        .padding()
        .frame(height: 200)
    }
    
    private func avgRatingView() -> some View {
        HStack(spacing: 3) {
            Text(avgRating!) // тк выше проверил на != nil, что значение там есть, то так можно)
                .font(.system(size: Consts.textSize))
            Image(systemName: Consts.starImageFill)
                .resizable()
                .frame(width: Consts.iconStarWidth, height: Consts.iconStarHeight)
        }
        .foregroundStyle(Color.customLightGray)
    }
    
    private func favoriteImageView() -> some View {
        Image(systemName: Consts.bookmarkImage)
            .resizable()
            .frame(width: Consts.iconBookmarkWidth, height: Consts.iconBookmarkHeight)
            .foregroundStyle(Color.yellow)
            .padding(.horizontal, Consts.iconBookmarkHorPadding)
    }
    
    private func realeseDateView() -> some View {
        Text(realeseDate!) // сделал проверку на nil перед вызовом
            .foregroundStyle(Color.customLightGray)
            .padding(5)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(Color.customSuperLightGray)
            }
    }
    
    private func descriptionView() -> some View {
        Text(description)
            .foregroundStyle(Color.customLightGray)
            .font(.system(size: Consts.textSize))
            .frame(maxHeight: Consts.maxTextHeight)
            .multilineTextAlignment(.leading)
    }
    
    private func titleView() -> some View {
        Text(name)
            .foregroundStyle(Color.customBlack)
            .font(.system(size: Consts.textTitleSize))
            .bold()
    }
    
    private func seriesCountView() -> some View {
        Text(seriesCount!) // проверка сделана
            .foregroundStyle(Color.customLightGray)
            .padding(.vertical, Consts.seriesCountVertPadding)
    }
    
    enum Consts {
        static var maxTextHeight: CGFloat = 80
        static var textSize: CGFloat = 18
        static var textTitleSize: CGFloat = 22
        static var iconStarWidth: CGFloat = 15
        static var iconStarHeight: CGFloat = 15
        static var starImageFill: String = "star.fill"
        static var bookmarkImage: String = "bookmark.fill"
        static var iconBookmarkWidth: CGFloat = 12
        static var iconBookmarkHeight: CGFloat = 16
        static var iconBookmarkHorPadding: CGFloat = 4
        static var seriesCountVertPadding: CGFloat = 5
    }
}

//#Preview {
//    ListView(filterBy: .mySelection)
//}
