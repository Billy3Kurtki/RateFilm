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
    var createDate: Int
    var isEdit: Bool
    var countLike: Int
}
