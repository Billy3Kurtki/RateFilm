//
//  FavoritesView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 11.10.2023.
//

import SwiftUI

struct FavoritesView: View {
    @State private var searchText = ""
    @State private var selectedCategory: FavoritesViewSelections = .favourite
    @FocusState var focus: FocusElement?
    @Environment(AuthViewModel.self) private var authVM
    @State private var vm = FavoritesViewModel()
    
    var body: some View {
        NavigationStack {
            if authVM.currentUser?.userType != .unauthUser {
                CustomNavBarView(searchText: $searchText, focus: $focus, prompt: adaptivePrompt)
                if _focus.wrappedValue == .favoriteView {
                    if !vm.searchResults.isEmpty {
                        searchedResults()
                    } else if !searchText.isEmpty {
                        Text(LocalizedStrings.nothingFound.localizeString())
                            .multilineTextAlignment(.center)
                            .padding(Consts.padding)
                    }
                }
                else {
                    FavoritesHorizontalScrollView(selectedCategory: $selectedCategory)
                    TabView(selection: $selectedCategory) {
                        ForEach(FavoritesViewSelections.allCases, id: \.self) { selection in
                            ListView(snippets: vm.getFilteredList(by: selection))
                                .tag(selection)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .indexViewStyle(.page(backgroundDisplayMode: .never))
                }
                
                Spacer()
            } else {
                BlockingView()
            }
        }
        .onChange(of: searchText) { oldSearchTerm, newSearchTerm in
            vm.searchResults = vm.getFilteredList(by: selectedCategory).filter { snippet in
                snippet.name.lowercased().contains(newSearchTerm.lowercased())
            }
        }
        .onAppear {
            //            if let user = authVM.currentUser { // по идее здесь можно было сделать и ...(user: authVM.currentUser!), тк на этот экран можно перейти только если currentUser != nil
            //                Task {
            //                    await vm.fetchDataAsync(user: user)
            //                }
            //            }
            vm.fetchMockData()
        }
    }
    
    private func searchedResults() -> some View {
        VStack(alignment: .leading) {
            Text(LocalizedStrings.searchResults.localizeString())
                .font(.system(size: Consts.textSize))
                .foregroundStyle(Color.customBlack)
                .padding(.top, Consts.vertPadding)
                .padding(.horizontal, Consts.horPadding)
            ListView(snippets: vm.searchResults)
        }
    }
    
    var adaptivePrompt: String {
        "\(LocalizedStrings.searchIn.localizeString()) «\(selectedCategory.localizeString())»"
    }
    
    enum Consts {
        static var horPadding: CGFloat = 15
        static var vertPadding: CGFloat = 15
        static var padding: CGFloat = 15
        static var textSize: CGFloat = 18
    }
    
    enum LocalizedStrings: LocalizedStringKey {
        case search = "Search"
        case searchIn = "SearchIn"
        case searchResults = "searchResultsLabel"
        case nothingFound = "nothingFoundLabel"
        
        func localizeString() -> String {
            return NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
        }
    }
}

#Preview {
    FavoritesView()
}

struct FavoritesHorizontalScrollView: View {
    @Binding var selectedCategory: FavoritesViewSelections
    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer(minLength: 20)
                    ForEach(FavoritesViewSelections.allCases, id: \.self) { selection in
                        Button {
                            self.selectedCategory = selection
                        } label: {
                            Text(selection.localizeString())
                                .padding()
                                .foregroundStyle(self.selectedCategory == selection ? Color.accentColor : Color.customBlack)
                                .font(.system(size: 19))
                                .background(
                                    Capsule()
                                        .foregroundStyle(self.selectedCategory == selection ? Color.accentColor : Color.clear)
                                        .frame(height: 3)
                                        .offset(y: 22)
                                )
                        }
                    }
                }
                .padding(.horizontal)
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 20)) {
                    scrollProxy.scrollTo(selectedCategory, anchor: .center)
                }
            }
            .onChange(of: selectedCategory) { _, newValue in
                withAnimation(.easeInOut(duration: 20)) {
                    scrollProxy.scrollTo(newValue, anchor: .center)
                }
            }
        }
    }
}
