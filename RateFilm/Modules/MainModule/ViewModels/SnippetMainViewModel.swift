//
//  MovieViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 30.10.2023.
//

import Foundation

struct SnippetMainViewModel {
    var snippet: SnippetViewModel
    var mainViewSelection: [MainViewSelections]
}

enum MovieType {
    case film
    case serial
}
