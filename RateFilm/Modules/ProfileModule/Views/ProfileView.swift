//
//  ProfileView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 11.10.2023.
//

import SwiftUI

struct ProfileView: View {
    @Environment(AuthViewModel.self) private var authVM
    
    var body: some View {
        if authVM.currentUser?.userType != .unauthUser {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        } else {
            BlockingView()
        }
        
    }
}

#Preview {
    ProfileView()
}
