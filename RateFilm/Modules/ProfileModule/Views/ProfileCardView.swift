//
//  ProfileCard.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 18.12.2023.
//

import SwiftUI

struct ProfileCardView: View {
    var vm: ProfileCardViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if let user = vm.user {
                        userImage(url: user.imageStringUrl)
                        usernameView(username: user.username)
                        nameView(name: user.name)
                        editButtonView()
                        divider()
                        statisticStatusView(status: user.status)
                        Spacer()
                    } else {
                        ErrorView {
                            refreshData()
                        }
                    }
                }
            }
        }
        .onAppear {
//            vm.fetchMockUser()
            Task {
                await vm.fetchUserAsync()
            }
        }
    }
    
    private func refreshData() {
        Task {
            await vm.fetchUserAsync()
        }
    }
    
    
    private func userImage(url: String?) -> some View {
        VStack {
            if let imageStringUrl = url {
                UserAsyncImageView(urlString: imageStringUrl, width: Consts.iconWidth, height: Consts.iconHeight)
            } else {
                DefaultUserImageView(abbreviatedUsername: vm.user?.abbreviatedUsername, width: Consts.iconWidth, height: Consts.iconHeight)
            }
        }
        .padding(.top, 50)
    }
    
    private func usernameView(username: String) -> some View {
        VStack {
            Text(username)
                .font(.system(size: 20).bold())
                .foregroundStyle(Color.customBlack)
        }
        .padding(.vertical, 10)
    }
    
    private func nameView(name: String?) -> some View {
        VStack {
            if let name = name {
                Text(name)
                    .font(.system(size: 15))
                    .foregroundStyle(Color.customBlack)
            }
        }
    }
    
    private func editButtonView() -> some View {
        VStack {
            CustomButton(label: LocalizedStrings.edit.localizeString()) {
                
            }
        }
        .padding(.vertical, 25)
    }
    
    private func divider() -> some View {
        VStack {
            Capsule()
                .frame(height: Consts.capsuleHeight)
                .foregroundStyle(Color.customLightGray)
                .padding(.horizontal, 10)
        }
    }
    
    private func statisticStatusView(status: [MovieStatus : Int]) -> some View {
        VStack(alignment: .leading) {
            Text(LocalizedStrings.statistic.localizeString())
                .font(.system(size: 20).bold())
            HStack {
                VStack(alignment: .leading) {
                    ForEach(MovieStatus.allCases, id: \.self) { st in
                        if let exists = status[st] {
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
        }.padding(20)
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
    
    enum Consts {
        static var capsuleHeight: CGFloat = 2
        static var iconWidth: CGFloat = 100
        static var iconHeight: CGFloat = 100
    }
    
    enum LocalizedStrings: LocalizedStringKey {
        case edit = "EditLabel"
        case statistic = "StatisticLabel"
        
        func localizeString() -> String {
            return NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
        }
    }
}


//#Preview {
//    ProfileCard()
//}
