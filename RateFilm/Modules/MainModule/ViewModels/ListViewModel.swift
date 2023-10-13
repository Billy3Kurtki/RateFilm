//
//  ListViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 11.10.2023.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var films: [Film] = []
}

extension ListViewModel {
    func fetchData() {
        self.films = [
            Film(id: "1", name: "biba", releaseDate: .now, description: "boba", duration: 200, ageRating: 15, moveTypes: [MovieType.action], author: "Alyosha"),
            Film(id: "2", name: "biba2", releaseDate: .now, description: "boba2", duration: 200, ageRating: 15, moveTypes: [MovieType.action], author: "Alyosha2"),
            Film(id: "3", name: "biba3", releaseDate: .now, description: "boba3", duration: 200, ageRating: 15, moveTypes: [MovieType.action], author: "Alyosha3"),
            Film(id: "4", name: "biba4", releaseDate: .now, description: "boba4", duration: 200, ageRating: 15, moveTypes: [MovieType.action], author: "Alyosha4")
        ]
    }
}
