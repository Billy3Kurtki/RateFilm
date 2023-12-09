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
    var isLastRealesed: Bool
}

enum MovieType {
    case film
    case serial
}
