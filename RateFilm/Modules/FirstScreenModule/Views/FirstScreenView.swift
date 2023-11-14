//
//  FirstScreenView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 14.11.2023.
//

import SwiftUI

struct FirstScreenView: View {
    @State var animateIsActive = false
    @AppStorage("authUser") private var userAuthorized = false
    
    var body: some View {
        ZStack {
            SplashScreenView(isActive: $animateIsActive)
            
            Group {
                if !userAuthorized {
                    LoginView()
                } else {
                    ContentView()
                }
            }
            .opacity(animateIsActive ? 1 : 0)
            .animation(.easeOut.delay(0.15), value: animateIsActive)
        }
    }
}

#Preview {
    FirstScreenView()
}
