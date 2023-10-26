//
//  ListViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 11.10.2023.
//

import SwiftUI
import Observation

@Observable
class ListViewModel {
    var filmsVM: [FilmViewModel] = []
    var serialsVM: [SerialViewModel] = []
    
    init() {
        for i in ListViewModel.films {
            
            // MARK: Доп проверка: Оценки быть не должно, если Дата выхода не пришла или если Дата выхода > .now (скоро выйдет).
            var realeseDate: String?
            var avgRating: String?
            if let date = i.releaseDate {
                realeseDate = CustomFormatter.formatDateToCustomString(date: date)
                if realeseDate == nil {
                    avgRating = CustomFormatter.formatFloat(float: CustomFormatter.formatAvgRating(float: i.avgRating))
                }
            } else {
                realeseDate = String(localized: "comingSoon")
            }
            
            let filmVM = FilmViewModel(id: i.id, name: i.name, releaseDate: realeseDate, description: i.description, previewImage: i.previewImage, avgRating: avgRating)
            filmsVM.append(filmVM)
        }
    }
}

extension ListViewModel {
    static let films: [Film] = [
        Film(id: "1", name: "biba1", releaseDate: 1820241212121, description: "bobaboba bobabobaboba bobabobabobab obabobabobaboba bobabobabobabobabo babobabobabobab obabobabobabobabobabo babobabobabobab obabobabobabobabobabobabobabobabobaboba", duration: 200, previewImage: "https://i.pinimg.com/236x/1b/9b/34/1b9b3430f3e89b95c22937d7c353737e1.jpg", avgRating: 5.0, ageRating: 15, moveTypes: [MovieType.action], author: "Alyosha"),
        Film(id: "2", name: "biba2", releaseDate: 920241212121, description: "bobaboba bobabobaboba bobabobabobab obabobabobaboba bobabobabobabobabo babobabobabobab obabobabobabobabobabo babobabobabobab obabobabobabobabobabobabobabobabobaboba", duration: 200, previewImage: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/JPEG_example_down.jpg/350px-JPEG_example_down.jpg", avgRating: 4.0, ageRating: 15, moveTypes: [MovieType.action], author: "Alyosha2"),
        Film(id: "3", name: "biba3", description: "boba3", duration: 200, previewImage: "https://img.freepik.com/premium-photo/dcim-101media-dji-0067-jpg_665346-20571.jpg", avgRating: 2.0, ageRating: 15, moveTypes: [MovieType.action], author: "Alyosha3"),
        Film(id: "4", name: "biba4", releaseDate: 1820240212121, description: "boba4", duration: 200, previewImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTt584rMTJ8Yqb6UxgqiV130sgnmDVEMSp8Bw&usqp=CAU", avgRating: 4.2,ageRating: 15, moveTypes: [MovieType.action], author: "Alyosha4"),
        Film(id: "5", name: "biba5", releaseDate: 1820241212121, description: "boba", duration: 200, previewImage: "https://www.codeproject.com/KB/GDI-plus/ImageProcessing2/img.jpg", avgRating: 2.5, ageRating: 15, moveTypes: [MovieType.action], author: "Alyosha"),
        Film(id: "6", name: "biba6", description: "boba2", duration: 200, previewImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvd0sBonCGb8bGoHNjUMOspgI3AoI_UR89oQ&usqp=CAU", avgRating: 3.3, ageRating: 15, moveTypes: [MovieType.action], author: "Alyosha2"),
        Film(id: "7", name: "biba7", releaseDate: 1750241212121, description: "boba3", duration: 200, previewImage: "https://i.pinimg.com/236x/1b/9b/34/1b9b3430f3e89b95c22937d7c353737e.jpg", avgRating: 2.6, ageRating: 15, moveTypes: [MovieType.action], author: "Alyosha3"),
        Film(id: "8", name: "biba8", releaseDate: 1823241212121, description: "boba4", duration: 200, previewImage: "https://i.pinimg.com/236x/1b/9b/34/1b9b3430f3e89b95c22937d7c353737e.jpg", avgRating: 5.0, ageRating: 15, moveTypes: [MovieType.action], author: "Alyosha4")
    ]
    
    static let serials: [Serial] = [
        Serial(id: "1", name: "boba1", releaseDate: 1810241212121, description: "boba123123123", duration: 200, previewImage: "https://i.pinimg.com/236x/1b/9b/34/1b9b3430f3e89b95c22937d7c353737e.jpg", avgRating: 3.0, seriesCount: 15, seasons: [], ageRating: 12, moveTypes: [.action], author: "Alyshka"),
        Serial(id: "2", name: "boba2", releaseDate: 1710241212121, description: "boba123123123", duration: 200, previewImage: "https://i.pinimg.com/236x/1b/9b/34/1b9b3430f3e89b95c22937d7c353737e.jpg", avgRating: 4.0, seriesCount: 15, seasons: [], ageRating: 12, moveTypes: [.action], author: "Alyshka"),
        Serial(id: "3", name: "boba3", description: "boba123123123", duration: 200, previewImage: "https://i.pinimg.com/236x/1b/9b/34/1b9b3430f3e89b95c22937d7c353737e.jpg", avgRating: 5.0, seriesCount: 15, seasons: [], ageRating: 12, moveTypes: [.action], author: "Alyshka")
    ]
}
