//
//  RateFilmApp.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 02.10.2023.
//

import SwiftUI

@main
struct RateFilmApp: App {
    @State var authVM = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            FirstScreenView()
                .environment(authVM)
        }
    }
}
