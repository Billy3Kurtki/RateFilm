//
//  UserMiniViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 18.12.2023.
//

import Foundation

struct UserMiniViewModel: Identifiable {
    var id: String
    var username: String
    var abbreviatedUsername: String?
    var imageStringUrl: String?
}

extension UserMiniViewModel {
    init(userMini: UserMini) {
        self.id = userMini.id
        self.username = userMini.username
        self.abbreviatedUsername = CustomFormatter.formatUserName(userMini.username)
        self.imageStringUrl = userMini.image?.url
    }
}
