//
//  FavoritesViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 03.12.2023.
//

import Foundation
import Observation

@Observable
final class FavoritesViewModel {
    var snippets: [SnippetFavoritesViewModel] = []
    var searchResults: [SnippetFavoritesViewModel] = []
    
    let networkService = NetworkService()
    var error: NetworkError?
    
    init() {
        
    }
    
    func getFilteredList(by: FavoritesViewSelections) -> [SnippetFavoritesViewModel] {
        switch by {
        case .history:
            return [] // пока так
        case .favourite:
            return snippets.filter { $0.isFavorite == true }
        case .looking:
            return snippets.filter { $0.favoriteSelection == .looking }
        case .inThePlans:
            return snippets.filter { $0.favoriteSelection == .inThePlans }
        case .viewed:
            return snippets.filter { $0.favoriteSelection == .viewed }
        case .postponed:
            return snippets.filter { $0.favoriteSelection == .postponed }
        case .abandoned:
            return snippets.filter { $0.favoriteSelection == .abandoned }
        }
    }
}
