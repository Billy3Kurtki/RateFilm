//
//  UserViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 12.12.2023.
//

import Foundation

struct UserViewModel {
    var id: String
    var username: String
    var abbreviatedUsername: String?
    var imageStringUrl: String?
    var email: String
    var name: String?
    var phone: String?
    var age: Int?
    var status: [MovieStatus : Int]
}

extension UserViewModel {
    init(user: UserExtended) {
        self.id = user.id
        self.username = user.username
        self.abbreviatedUsername = CustomFormatter.formatUserName(user.username)
        self.imageStringUrl = user.image?.url
        self.email = user.email
        self.name = user.name
        self.phone = user.phone
        self.age = user.age
        self.status = [:]
        for i in user.statisticStatus {
            let tempStatus = CustomFormatter.convertStringToMovieStatus(i.key)
            self.status[tempStatus] = i.value
        }
    }
}
