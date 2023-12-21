//
//  CommentViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 21.12.2023.
//

import Foundation

struct CommentViewModel: Identifiable {
    var id: String
    var user: UserMiniViewModel
    var text: String
    var date: String
    var countLike: Int
}

extension CommentViewModel {
    init(comment: Comment) {
        self.id = comment.id
        self.text = comment.text
        self.date = CustomFormatter.convertDateToString(comment.date)
        self.countLike = comment.countLike
        self.user = UserMiniViewModel(userMini: comment.user)
    }
}
