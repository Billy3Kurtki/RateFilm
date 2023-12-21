//
//  CommentsView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 21.12.2023.
//

import SwiftUI

struct CommentsView: View {
    var movieId: String
    var movieType: MovieType
    
    var body: some View {
        NavigationStack {
//            CommentListView(comments: <#T##[CommentViewModel]#>)
        }
    }
}

#Preview {
    CommentsView(movieId: "1", movieType: .film)
}
