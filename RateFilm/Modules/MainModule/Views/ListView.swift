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
                ForEach(data.filmsVM) { film in
                    NavigationLink(destination: MovieDetailsView()) {
                        FilmCell(film: film)
                    }
                }
            }
        }
        .padding(.vertical, 20)
    }
}

struct FilmCell: View {
    var film: FilmViewModel
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: film.previewImage)) { data in
                if let image = data.image {
                    image
                        .resizable()
                        .frame(width: 100, height: 150) // вынести в consts
                } else if data.error != nil {
                    Image(uiImage: UIImage(named: "defaultImage")!)
                        .resizable()
                        .frame(width: 100, height: 150)
                } else {
                    ZStack {
                        RoundedRectangle(cornerSize: CGSize(width: 1, height: 1))
                            .opacity(0)
                        ProgressView() // пока плохо
                    }
                    
                }
            }
            VStack { // вынести в отдельные View
                HStack {
                    Text(film.name)
                        .foregroundStyle(.black)
                        .font(.system(size: 22))
                        .bold()
                    Spacer()
                }
                HStack {
                    Text(film.avgRating)
                    Image(systemName: "star.fill")
                    Spacer()
                }
                .foregroundStyle(Color("lightGray"))
                HStack {
                    Text(film.description)
                        .foregroundStyle(.gray)
                        .font(.system(size: 20))
                        .frame(maxHeight: 80)
                    Spacer()
                }
                Spacer()
            }
            Spacer()
        }.padding()
    }
}


#Preview {
    ListView()
}
