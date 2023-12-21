//
//  MovieDetailsView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 11.10.2023.
//

import SwiftUI

struct MovieDetailsView: View {
    @State var vm: MovieDetailsViewModel
    @AppStorage("systemThemeVal") private var systemTheme: String = SchemeType.allCases.first!.rawValue
    
    @State private var statusSelection: MovieStatus = .none
    @State private var isFavorite = false
    @State private var linkToCommentsView = false
    @State private var showFullDescription = false
    
    var body: some View {
        NavigationStack {
            if let _ = vm.error {
                ErrorView {
                    refreshData()
                }
            } else {
                movieDetailsView()
            }
        }
        .onAppear {
            refreshData()
//            vm.fetchMockMovie(vm.movieType)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // потом надо будет добавить какой-нибудь loadingState вместо этого
                if let card = vm.card {
                    statusSelection = card.status
                    isFavorite = card.isFavorite
                }
            }
        }
        .onChange(of: statusSelection) { oldValue, newValue in
            vm.card?.status = newValue
        }
        .onChange(of: isFavorite) { oldValue, newValue in
            vm.card?.isFavorite = newValue
        }
    }
    
    
    var movie: MovieCard? {
        vm.card
    }
    
    private func refreshData() {
        Task {
            await vm.fetchMovie(user: vm.user)
        }
        if let status = vm.card?.status {
            statusSelection = status
        }
    }
    
    private func movieDetailsView() -> some View {
        ScrollView {
            VStack {
                ZStack {
                    imageBackgroundView()
                    imageView()
                }
                titleView()
                buttonsBlock()
                infoView()
                descriptionView()
                ratingsView()
                statisticStatusView()
                imagesView()
                commentsView()
                Spacer()
            }
            .frame(width: 500)
        }
    }
    
    private func imageView() -> some View {
        VStack {
            if let movie = movie {
                AsyncImage(url: URL(string: movie.previewImage.url)) { data in
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
                
            }
        }
        .frame(width: Consts.imageWidth, height: Consts.imageHeight)
    }
    
    private func imageBackgroundView() -> some View {
        VStack {
            if let movie = movie {
                AsyncImage(url: URL(string: movie.previewImage.url)) { data in
                    if let image = data.image {
                        image
                            .imageIconModifier()
                    } else if data.error != nil {
                        Consts.defaultImage
                            .imageIconModifier()
                    }
                }
                
            }
        }
        .frame(width: Consts.imageBackgroundWidth, height: Consts.imageBackgroundHeight)
        .opacity(Consts.imageBackgroundOpacity)
    }
    
    private func titleView() -> some View {
        VStack {
            HStack {
                if let movie = movie {
                    Text(movie.name)
                        .font(.system(size: 20).bold())
                        .foregroundStyle(Color.customBlack)
                    Text(movie.ageRating)
                        .foregroundStyle(Color.customWhite)
                        .font(.system(size: 17))
                        .padding(4)
                        .background {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundStyle(Color.customBlack)
                        }
                    Spacer()
                }
            }
            .padding(.horizontal, 70)
        }
    }
    
    private func buttonsBlock() -> some View {
        HStack {
            statusPickerView()
            favoriteButtonView()
            toCommentButtonView()
            Spacer()
        }
        .padding(.horizontal, 70)
    }
    
    private func statusPickerView() -> some View {
        VStack {
            Menu {
                Picker(selection: $statusSelection) {
                    ForEach(MovieStatus.allCases, id: \.self) { status in
                        Text(status.localizeString())
                    }
                } label: {
                    
                }
                
            } label: {
                Text(statusSelection.localizeString())
                Image(systemName: Consts.toggleImage)
            }
            .foregroundStyle(favoriteColor)
            .padding(9)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1.0)
                    .foregroundStyle(favoriteColor)
            }
        }
        .padding(.horizontal, 5)
    }
    
    var favoriteColor: Color {
        switch statusSelection {
        case .none:
            return .customGray
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
    
    private func favoriteButtonView() -> some View {
        VStack {
            Button {
                isFavorite.toggle()
            } label: {
                Image(systemName: isFavorite ? Consts.bookmarkFillImage : Consts.bookmarkImage)
                    .resizable()
                    .frame(width: Consts.iconBookmarkWidth, height: Consts.iconBookmarkHeight)
                    .foregroundStyle(isFavorite ? Color.yellow : Color.customGray)
                    .padding(Consts.iconBookmarkPadding)
                    .background {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 1.0)
                            .foregroundStyle(isFavorite ? Color.yellow : Color.customLightGray)
                    }
            }
        }
        .padding(.horizontal, 5)
    }
    
    private func toCommentButtonView() -> some View {
        VStack {
            NavigationLink(destination: CommentsView(movieId: vm.movieId, movieType: vm.movieType), isActive: $linkToCommentsView) {
                Button {
                    linkToCommentsView.toggle()
                } label: {
                    Image(systemName: Consts.commentImage)
                        .resizable()
                        .frame(width: Consts.iconCommentWidth, height: Consts.iconCommentHeight)
                        .foregroundStyle(Color.customGray)
                        .padding(Consts.iconBookmarkPadding)
                        .background {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 1.0)
                                .foregroundStyle(Color.customLightGray)
                        }
                }
            }
        }
        .padding(.horizontal, 5)
    }
    
    private func infoView() -> some View {
        VStack {
            if let movie = movie {
                HStack {
                    Image(systemName: Consts.calendarImage)
                        .frame(width: Consts.iconCommentWidth, height: Consts.iconCommentHeight)
                        .foregroundStyle(Color.customLightGray)
                    Text(movie.releaseDate)
                    Spacer()
                }
                if movie.movieType == .serial {
                    HStack {
                        Image(systemName: Consts.playVideoImage)
                            .frame(width: Consts.iconCommentWidth, height: Consts.iconCommentHeight)
                            .foregroundStyle(Color.customLightGray)
                        Text(movie.seriesCount!)
                        Spacer()
                    }
                }
                HStack {
                    Image(systemName: Consts.movieTypeImage)
                        .frame(width: Consts.iconCommentWidth, height: Consts.iconCommentHeight)
                        .foregroundStyle(Color.customLightGray)
                    Text(movie.movieTypeString)
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 70)
        .padding(.top, 30)
    }
    
    private func descriptionView() -> some View {
        VStack {
            if let movie = movie {
                HStack {
                    Text(LocalizedStrings.description.localizeString())
                        .font(.system(size: 18))
                    Spacer()
                }
                .padding(.bottom, 10)
                HStack {
                    Text(movie.description)
                        .lineLimit(showFullDescription ? 15 : 3)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                    
                Button {
                    showFullDescription = true
                } label: {
                    Text(LocalizedStrings.moreDetails.localizeString())
                        .foregroundStyle(Color.customLightRed)
                }
                .padding(.top, 1)
                .opacity(showFullDescription ? 0 : 1)
            }
        }
        .padding(.horizontal, 70)
        .padding(.vertical)
    }
    
    private func ratingsView() -> some View {
        VStack {
            if let movie = movie {
                HStack {
                    Text(LocalizedStrings.rating.localizeString())
                        .font(.system(size: 20).bold())
                        .foregroundStyle(Color.customLightGray)
                    Spacer()
                }
                .padding(.vertical)
                HStack {
                    VStack {
                        Text(movie.avgRating)
                            .foregroundStyle(Color.customBlack)
                            .font(.system(size: 40).bold())
                        HStack {
                            Text("\(movie.countRatings)") // плохо конечно, но пока так
                            Text("\(LocalizedStrings.votes.localizeString()).")
                        }
                        .foregroundStyle(Color.customLightGray)
                    }
                    .padding(25)
                    VStack {
                        ratingsStatistic(ratings: movie.ratings)
                    }
                }
            }
        }
        .padding(.horizontal, 70)
    }
    
    private func ratingsStatistic(ratings: [Int : Int]? = [:]) -> some View {
        VStack {
            if let movie = movie {
                ForEach(Ratings.allCases.reversed(), id: \.self) { rating in
                    HStack {
                        HStack {
                            Spacer()
                            Text("\(rating.rawValue)")
                        }
                        ZStack {
                            HStack {
                                Capsule()
                                    .frame(width: Consts.statisticBackLineWidth, height: Consts.statisticBackLineHeight)
                                    .foregroundStyle(Color.customLightGray)
                                Spacer()
                            }
                            HStack {
                                if let ratingsExists = ratings {
                                    if let countRatings = ratingsExists[rating.rawValue] {
                                        if countRatings > 0 {
                                            Capsule()
                                                .frame(width: Consts.statisticBackLineWidth * CGFloat(countRatings) / CGFloat(movie.countRatings), height: Consts.statisticBackLineHeight)
                                                .foregroundStyle(Color.orange)
                                            Spacer()
                                        }
                                    }
                                    
                                }
                                
                                
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
    }
    
    private func statisticStatusView() -> some View {
        VStack(alignment: .leading) {
            if let movie = movie {
                Text(LocalizedStrings.inPeopleList.localizeString())
                    .font(.system(size: 20).bold())
                    .foregroundStyle(Color.customLightGray)
                HStack {
                    VStack(alignment: .leading) {
                        ForEach(MovieStatus.allCases, id: \.self) { st in
                            if let exists = movie.statusOfPeople[st] {
                                HStack {
                                    Capsule()
                                        .fill()
                                        .foregroundStyle(favoriteColor(favoriteSelection: st))
                                        .frame(width: 10, height: 10)
                                    Text("\(st.localizeString()): ")
                                        .foregroundStyle(Color.customLightGray)
                                    Text("\(exists)")
                                        .foregroundStyle(Color.customBlack)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 70)
        .padding(.vertical, 30)
    }
    
    private func imagesView() -> some View {
        VStack {
            if let images = movie?.images {
                HStack {
                    Text(LocalizedStrings.frames.localizeString())
                        .font(.system(size: 20).bold())
                        .foregroundStyle(Color.customLightGray)
                    Spacer()
                }
                .padding(.horizontal, 70)
                TabView {
                    ForEach(images) { image in
                        ImageItemView(image: image)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            }
        }
        .frame(height: 200)
    }
    
    private func commentsView() -> some View {
        VStack {
            if let comments = movie?.comments {
                VStack {
                    HStack {
                        Text(LocalizedStrings.comments.localizeString())
                            .font(.system(size: 20).bold())
                            .foregroundStyle(Color.customLightGray)
                        Spacer()
                        NavigationLink(destination: CommentsView(movieId: vm.movieId, movieType: vm.movieType)) {
                            Button {
                                linkToCommentsView.toggle()
                            } label: {
                                Text(LocalizedStrings.showAll.localizeString())
                                    .foregroundStyle(Color.customLightRed)
                            }
                        }
                        
                    }
                    
                    CommentListView(comments: comments)
                }
            }
        }
        .padding(.horizontal, 70)
        .padding(.top, 30)
    }
    
    private func favoriteColor(favoriteSelection: MovieStatus) -> Color {
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
    
    enum Ratings: Int, CaseIterable {
        case one = 1
        case two = 2
        case three = 3
        case four = 4
        case five = 5
    }
    
    
    enum Consts {
        static var imageWidth: CGFloat = 250
        static var imageHeight: CGFloat = 350
        static var imageBackgroundWidth: CGFloat = 460
        static var imageBackgroundHeight: CGFloat = 375
        static var imageBackgroundOpacity: Double = 0.08
        static var defaultImage: Image = Image(uiImage: UIImage(named: "defaultImage")!)
        static var cornerRadius: CGFloat = 6
        static var opacity: Double = 0.8
        static var bookmarkFillImage: String = "bookmark.fill"
        static var bookmarkImage: String = "bookmark"
        static var iconBookmarkWidth: CGFloat = 14
        static var iconBookmarkHeight: CGFloat = 20
        static var iconBookmarkPadding: CGFloat = 9
        static var commentImage: String = "ellipsis.message"
        static var iconCommentWidth: CGFloat = 20
        static var iconCommentHeight: CGFloat = 20
        static var iconCommentPadding: CGFloat = 9
        static var toggleImage: String = "chevron.up.chevron.down"
        static var calendarImage: String = "calendar"
        static var playVideoImage: String = "play.rectangle.on.rectangle.fill"
        static var movieTypeImage: String = "list.clipboard"
        static var statisticBackLineWidth: CGFloat = 150
        static var statisticBackLineHeidth: CGFloat = 10
//        static var statisticLineWidth: CGFloat = 150
        static var statisticBackLineHeight: CGFloat = 10
    }
    
    enum LocalizedStrings: LocalizedStringKey {
        case moreDetails = "MoreDetailsLabel"
        case description = "descriptionLabel"
        case rating = "RatingLabel"
        case inPeopleList = "InPeopleListLabel"
        case votes = "VotesShortLabel"
        case frames = "FramesLabel"
        case comments = "CommentsLabel"
        case showAll = "ShowAllLabel"
        
        func localizeString() -> String {
            return NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
        }
    }
}

#Preview {
    MovieDetailsView(vm: MovieDetailsViewModel(movieId: "1", movieType: .serial, user: User(id: "1", userName: "", userType: .authUser, token: "")))
}

struct ImageItemView: View {
    let image: ImageModel
    
    var body: some View {
        AsyncImage(url: URL(string: image.url)) { data in
            if let image = data.image {
                image
                    .imageIconModifier()
                    
            } else {
                ProgressView()
            }
        }
        .frame(width: Consts.imageWidth, height: Consts.imageHeigth)
        .clipShape(.rect(cornerRadius: 13))
    }
    
    enum Consts {
        static var imageWidth: CGFloat = 300
        static var imageHeigth: CGFloat = 175
    }
}
 
