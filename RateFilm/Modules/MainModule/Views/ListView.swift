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
            AsyncIconRowView(urlString: snippet.previewImage)
            
            DescriptionView(name: snippet.name, description: snippet.description, seriesCount: snippet.seriesCount, realeseDate: snippet.releaseDate, avgRating: snippet.avgRating)
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
    var seriesCount, realeseDate, avgRating: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer(minLength: 5)
            Text(name)
                .foregroundStyle(Color.customBlack)
                .font(.system(size: Consts.textTitleSize))
                .bold()
            if let seriesCount = seriesCount {
                Text(seriesCount)
                    .foregroundStyle(Color.customLightGray)
                    .padding(.vertical, 5)
            }
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
                            .foregroundStyle(Color.customSuperLightGray)
                    }
            }
            
            Text(description)
                .foregroundStyle(Color.customLightGray)
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
        static var textSize: CGFloat = 18
        static var textTitleSize: CGFloat = 22
        static var iconStarWidth: CGFloat = 18
        static var iconStarHeight: CGFloat = 18
    }
}

//#Preview {
//    ListView(filterBy: .mySelection)
//}
