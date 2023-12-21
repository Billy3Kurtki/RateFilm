//
//  CommentListView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 22.12.2023.
//

import SwiftUI

struct CommentListView: View {
    var comments: [CommentViewModel]
    
    var body: some View {
        ForEach(comments) { comment in
            CommentCell(comment: comment)
        }
    }
}

struct CommentCell: View {
    var comment: CommentViewModel
    @State private var linkToUserProfile = false
    
    var body: some View {
        HStack {
            VStack {
                NavigationLink(destination: ProfileCardView(vm: ProfileCardViewModel(username: comment.user.username)), isActive: $linkToUserProfile) {
                    Button {
                        linkToUserProfile.toggle()
                    } label: {
                        if let url = comment.user.imageStringUrl {
                            UserAsyncImageView(urlString: url, width: Consts.iconWidth, height: Consts.iconHeight, isMini: true)
                        } else {
                            DefaultUserImageView(abbreviatedUsername: comment.user.abbreviatedUsername, width: Consts.iconWidth, height: Consts.iconHeight, isMini: true)
                        }
                    }
                }
                Spacer()
            }
            VStack {
                HStack {
                    Text(comment.user.username)
                        .font(.system(size: 15).bold())
                        .foregroundStyle(Color.customGray)
                    
                    Text(comment.date)
                        .font(.system(size: 16))
                        .foregroundStyle(Color.customLightGray)
                        .padding(.leading, 6)
                    Spacer()
                }
                HStack {
                    Text(comment.text)
                        .font(.system(size: 16))
                        .foregroundStyle(Color.customBlack)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                Spacer()
            }
        }
        .padding(.vertical, 5)
    }
    
    enum Consts {
        static var iconWidth: CGFloat = 40
        static var iconHeight: CGFloat = 40
    }
}

#Preview {
    CommentListView(comments: [])
}
