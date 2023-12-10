//
//  MovieDetailsView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 11.10.2023.
//

import SwiftUI

struct MovieDetailsView: View {
    @State private var showingOptions = false
    
    var body: some View {
        Button {
            showingOptions.toggle()
        } label: {
            Text("brbbr")
        }
        .sheet(isPresented: $showingOptions) {
            Text("Krokodile")
        }
    }
}

#Preview {
    MovieDetailsView()
}
