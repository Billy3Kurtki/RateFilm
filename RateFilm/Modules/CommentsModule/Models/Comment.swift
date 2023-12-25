//
//  Comment.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 09.12.2023.
//

import Foundation

struct Comment: Codable {
    var id: String
    var user: UserMini
    var text: String
    var date: Int
    var countLike: Int
    var isLiked: Bool
}
