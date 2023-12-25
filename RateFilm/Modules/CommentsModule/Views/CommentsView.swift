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
                ErrorView(action: {
                    refreshData()
                })
            } else {
                ZStack {
                    ScrollView {
                        CommentListView(comments: vm.comments)
                    }
                    VStack {
                        Spacer()
                        ZStack {
                            EntryField(prompt: LocalizedStrings.enterComment.localizeString(), errorValidText: "", field: $commentText)
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
                                    Image(systemName: "paperplane")
                                        .frame(width: 20, height: 20)
                                        .foregroundStyle(Color.customBlack)
                                }
                            }
                            .padding(.horizontal, 25)
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

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
