//
//  ReviewView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 11.10.2023.
//

import SwiftUI

struct SearchView: View {
    @State var vm = MainViewModel()
    @State var searchTerm = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(LocalizedStrings.search.localizeString())
                    .font(.title.weight(.bold))
                Text(LocalizedStrings.enterMovieName.localizeString())
                    .multilineTextAlignment(.center)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundStyle(Color.customLightGray)
            .navigationTitle(LocalizedStrings.search.localizeString())
        }
        .searchable(text: $searchTerm) {
            if !vm.searchResults.isEmpty {
                Text(LocalizedStrings.searchResults.localizeString())
                    .font(.title3)
                    .foregroundStyle(Color.customBlack)
                ForEach(vm.searchResults) { snippet in
                    SnippetCell(snippet: snippet)
                }
            } else if !searchTerm.isEmpty {
                Text(LocalizedStrings.nothingFound.localizeString())
                    .multilineTextAlignment(.center)
            }
        }
        .onChange(of: searchTerm) { oldSearchTerm, newSearchTerm in
            vm.searchResults = vm.snippets.filter { snippet in
                snippet.name.lowercased().contains(newSearchTerm.lowercased())
            }
        }
    }
    
    enum LocalizedStrings: LocalizedStringKey {
        case search = "searchLabel"
        case enterMovieName = "enterMovieNameLabel"
        case searchResults = "searchResultsLabel"
        case nothingFound = "nothingFoundLabel"
        
        func localizeString() -> String {
            return NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
        }
    }
}

#Preview {
    SearchView()
}


