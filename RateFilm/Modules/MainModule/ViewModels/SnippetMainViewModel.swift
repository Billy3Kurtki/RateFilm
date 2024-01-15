//
//  MovieViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 30.10.2023.
//

import Foundation

struct SnippetMainViewModel {
    var snippet: SnippetViewModel
    var isAnnouncement: Bool
    var isOngoing: Bool?
    var isLastReleased: Bool
}

enum MovieType {
    case film
    case serial
}
