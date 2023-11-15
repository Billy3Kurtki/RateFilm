//
//  FirstScreenView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 14.11.2023.
//

import SwiftUI

struct FirstScreenView: View {
    @State var animateIsActive = false
    @Environment(AuthViewModel.self) private var authVM
    
    var body: some View {
        ZStack {
            SplashScreenView(isActive: $animateIsActive)
            
            Group {
                if authVM.currentUser == nil {
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
