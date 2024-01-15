//
//  CommentListView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 22.12.2023.
//

import SwiftUI

struct CommentListView: View {
    var comments: [CommentVM]
    
    var body: some View {
        ForEach(comments) { comment in
            CommentCell(vm: CommentCellViewModel(comment: comment))
        }
    }
}

struct CommentCell: View {
    @State var vm: CommentCellViewModel
    @Environment(AuthViewModel.self) private var authVM
    @State private var linkToUserProfile = false
    
    @State private var linkToLoginView = false
    @State private var showingConfirmation = false
    
    var body: some View {
        HStack {
            VStack {
                userIconView()
                Spacer()
            }
            .padding(.trailing, 10)
            VStack {
                HStack {
                    usernameView()
                    
                    commentDateView()
                    
                    Spacer()
                }
                commentTextView()
                HStack {
                    Spacer()
                    
                    likeButton()
                    
                    countLikeView()
                }
                Spacer()
            }
        }
        .padding(.vertical, 5)
        .confirmationDialog("LoginLabel", isPresented: $showingConfirmation) {
            Button {
                linkToLoginView.toggle()
            } label: {
                Text(LocalizedStrings.authorization.localizeString())
            }
        } message: {
            Text(LocalizedStrings.needToLogin.localizeString())
        }
    }
    
    private func userIconView() -> some View {
        NavigationLink(destination: ProfileCardView(vm: ProfileCardViewModel(username: vm.comment.user.username)), isActive: $linkToUserProfile) {
            Button {
                linkToUserProfile.toggle()
            } label: {
                if let url = vm.comment.user.imageStringUrl {
                    UserAsyncImageView(urlString: url, width: Consts.iconWidth, height: Consts.iconHeight, isMini: true)
                } else {
                    DefaultUserImageView(abbreviatedUsername: vm.comment.user.abbreviatedUsername, width: Consts.iconWidth, height: Consts.iconHeight, isMini: true)
                }
            }
        }
    }
    
    private func usernameView() -> some View {
        Text(vm.comment.user.username)
            .font(.system(size: 15).bold())
            .foregroundStyle(Color.customGray)
    }
    
    private func commentDateView() -> some View {
        Text(vm.comment.date)
            .font(.system(size: 16))
            .foregroundStyle(Color.customLightGray)
            .padding(.leading, 6)
    }
    
    private func commentTextView() -> some View {
        HStack {
            Text(vm.comment.text)
                .font(.system(size: 16))
                .foregroundStyle(Color.customBlack)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
            Spacer()
        }
    }
    
    private func likeButton() -> some View {
        NavigationLink(destination: LoginView(), isActive: $linkToLoginView) {
            Button {
                Task {
                    authVM.currentUser?.userType == .unauthUser ? showingConfirmation.toggle() : await vm.changeCommentLike(user: authVM.currentUser!)
                }
            }
            label: {
                Image(systemName: vm.comment.isLiked ? Consts.iconHeartFill : Consts.iconHeart)
                    .foregroundStyle(vm.comment.isLiked ? Color.red : Color.customGray)
            }
        }
    }
    
    private func countLikeView() -> some View {
        Text("\(vm.comment.countLike)")
            .font(.system(size: 16))
            .foregroundStyle(Color.customLightGray)
            .padding(.trailing, 10)
            .padding(.top, 2)
    }
    
    enum LocalizedStrings: LocalizedStringKey {
        case authorization = "authorizationLabel"
        case needToLogin = "NeedToLoginLabel"
        
        func localizeString() -> String {
            return NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
        }
    }
    
    enum Consts {
        static var iconWidth: CGFloat = 40
        static var iconHeight: CGFloat = 40
        static var iconHeart: String = "heart"
        static var iconHeartFill: String = "heart.fill"
        static var iconHearthWidth: CGFloat = 15
        static var iconHearthHeight: CGFloat = 15
    }
}

#Preview {
    CommentListView(comments: [CommentVM(comment: MovieDetailsViewModel.comment1), CommentVM(comment: MovieDetailsViewModel.comment2)])
}
