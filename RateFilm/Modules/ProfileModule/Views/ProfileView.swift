//
//  ProfileView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 11.10.2023.
//

import SwiftUI

struct ProfileView: View {
    @Environment(AuthViewModel.self) private var authVM
    @State var vm = ProfileViewModel()
    @State private var searchText = ""
    @FocusState var focus: FocusElement?
    
    var body: some View {
        NavigationStack {
            if authVM.currentUser?.userType != .unauthUser {
                
                CustomNavBarView(searchText: $searchText, focus: $focus, prompt: LocalizedStrings.findUsers.localizeString())
                if _focus.wrappedValue == .mainView {
                    if !vm.searchResults.isEmpty {
                        searchedResults()
                    } else if !searchText.isEmpty {
                        Text(LocalizedStrings.nothingFound.localizeString())
                            .multilineTextAlignment(.center)
                            .padding(Consts.padding)
                    }
                } else {
                    if let user = authVM.currentUser {
                        ProfileCardView(vm: ProfileCardViewModel(username: user.userName)) // потому что я в условии выше проверил его на != 0
                    }
                }
                
                Spacer()
            } else {
                BlockingView()
            }
        }
        .onChange(of: searchText) { oldSearchTerm, newSearchTerm in
//            Task {
//                await vm.getUsersByUsernameAsync(username: newSearchTerm)
//            }
            vm.searchResults = vm.users.filter { user in
                user.username.lowercased().contains(newSearchTerm.lowercased())
            }
        }
        .onAppear {
            vm.fetchMockUsers()
        }
    }
    
    private func searchedResults() -> some View {
        VStack(alignment: .leading) {
            Text(LocalizedStrings.searchResults.localizeString())
                .font(.system(size: Consts.textSize))
                .foregroundStyle(Color.customBlack)
                .padding(.top, Consts.vertPadding)
                .padding(.horizontal, Consts.horPadding)
            
            UserListView(users: vm.searchResults)
        }
    }
    
    enum Consts {
        static var horPadding: CGFloat = 15
        static var vertPadding: CGFloat = 15
        static var padding: CGFloat = 15
        static var textSize: CGFloat = 18
    }
    
    enum LocalizedStrings: LocalizedStringKey {
        case findUsers = "FindUsersLabel"
        case searchResults = "searchResultsLabel"
        case nothingFound = "nothingFoundLabel"
        
        func localizeString() -> String {
            return NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
        }
    }
}

struct UserListView: View {
    var users: [UserMiniViewModel]
    
    var body: some View {
        List(users) { user in
            UserCell(user: user)
        }
    }
}

struct UserCell: View {
    var user: UserMiniViewModel
    
    var body: some View {
        NavigationStack {
            HStack {
                if let url = user.imageStringUrl{
                    UserAsyncImageView(urlString: url, width: Consts.iconWidth, height: Consts.iconHeight, isMini: true)
                } else {
                    DefaultUserImageView(abbreviatedUsername: user.abbreviatedUsername, width: Consts.iconWidth, height: Consts.iconHeight, isMini: true)
                }
                
                VStack(alignment: .leading) {
                    Text(user.username)
                        .foregroundStyle(Color.customBlack)
                }
                .padding(.leading, 10)
            }
        }
    }
    
    enum Consts {
        static var iconWidth: CGFloat = 40
        static var iconHeight: CGFloat = 40
    }
}

struct UserAsyncImageView: View {
    var urlString: String
    var width: CGFloat
    var height: CGFloat
    var isMini: Bool = false
    
    var body: some View {
        AsyncImage(url: URL(string: urlString)) { data in
            if let image = data.image {
                image
                    .imageIconModifier()
            } else if data.error != nil {
                DefaultUserImageView(width: width, height: height, isMini: isMini)
            } else {
                ZStack {
                    Capsule()
                        .foregroundStyle(Color.customBlack)
                    ProgressView()
                }
            }
        }
        .frame(width: width, height: height)
        .clipShape(Capsule())
    }
}

struct DefaultUserImageView: View {
    var abbreviatedUsername: String?
    var width: CGFloat
    var height: CGFloat
    var isMini: Bool = false
    
    var body: some View {
        ZStack {
            Capsule()
                .foregroundStyle(Color.customGray)
            if let abbreviatedUsername = abbreviatedUsername {
                Text(abbreviatedUsername)
                    .font(.system(size: isMini ? 18 : 28).bold())
                    .foregroundStyle(Color.customWhite)
            } else {
                Image(systemName: "person")
                    .font(.system(size: isMini ? 24 : 38).bold())
                    .foregroundStyle(Color.customWhite)
            }
        }
        .frame(width: width, height: height)
    }
}

#Preview {
    ProfileView()
}
