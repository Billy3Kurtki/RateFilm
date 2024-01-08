//
//  CommentsView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 21.12.2023.
//

import SwiftUI

struct CommentsView: View {
    @State var vm: CommentsViewModel
    @State private var commentText = ""
    
    var body: some View {
        NavigationStack {
            if let _ = vm.error {
                ErrorView {
                    refreshData()
                }
            } else {
                ZStack {
                    ScrollView {
                        CommentListView(comments: vm.comments)
                    }
                    VStack {
                        Spacer()
                        ZStack {
                            EntryField(prompt: LocalizedStrings.enterComment.localizeString(), errorValidText: "", field: $commentText)
                            sendCommentButton()
                        }
                    }
                }
            }
        }
        .navigationTitle(LocalizedStrings.comments.localizeString())
        .onAppear {
            refreshData()
        }
        
    }
    
    func refreshData() {
        Task {
            await vm.fetchCommentsAsync()
        }
    }
    
    private func sendCommentButton() -> some View {
        HStack {
            Spacer()
            Button {
                Task {
                    let request = await vm.addComment(text: commentText)
                    if request {
                        commentText = ""
                    }
                }
            } label: {
                Image(systemName: Consts.sendButtonImage)
                    .frame(width: Consts.sendButtonWidth, height: Consts.sendButtonHeight)
                    .foregroundStyle(Color.customBlack)
            }
        }
        .padding(.horizontal, Consts.sendButtonPadding)
    }
    
    enum Consts {
        static var sendButtonImage = "paperplane"
        static var sendButtonWidth: CGFloat = 20
        static var sendButtonHeight: CGFloat = 20
        static var sendButtonPadding: CGFloat = 25
    }
    
    enum LocalizedStrings: LocalizedStringKey {
        case comments = "CommentsLabel"
        case enterComment = "EnterCommentLabel"
        
        func localizeString() -> String {
            return NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
        }
    }
}

#Preview {
    CommentsView(vm: CommentsViewModel(movieId: "1", movieType: .film, user: User(id: "1", userName: "adada", userType: .authUser, token: "")))
}
