//
//  ListView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 11.10.2023.
//

import SwiftUI

struct ListView: View {
    @State private var search = ""
    @StateObject private var data = ListViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(data.films) { film in
                    NavigationLink(destination: MovieDetailsView()) {
                        ListCell(film: film)
                    }
                }
            }
        }
        .padding(.vertical, 20)
        .onAppear {
            data.fetchData()
        }
    }
}

struct ListCell: View {
    var film: Film
    var body: some View {
        HStack {
            VStack {
                Text(film.name)
                    .font(.system(size: 20))
                Text(film.description)
            }
            Spacer()
        }
    }
}

#Preview {
    ListView()
}
