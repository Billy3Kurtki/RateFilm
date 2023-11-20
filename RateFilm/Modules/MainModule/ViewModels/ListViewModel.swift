//
//  ListViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 11.10.2023.
//

import SwiftUI
import Observation

@Observable
final class ListViewModel {
//    var filmsVM: [FilmViewModel] = []
//    var serialsVM: [SerialViewModel] = []
    var snippetsVM: [SnippetViewModel] = []
    var searchResults: [SnippetViewModel] = []
    
    init() {
        let now = Date.now.unixTimestamp
        let startDate: Int = now - 2 * UnixConsts.unixMonth
        let endDate: Int = now
        let range = startDate...endDate
        // MARK: Перегон фильмов
        for i in ListViewModel.films {
            var avgRating: String?
            var realeseDate: String?
            var selections: [MainViewSelections] = [.films]
            //допилить
            if let date = i.releaseDate {
                realeseDate = CustomFormatter.formatDateToCustomString(unix: date)
                if realeseDate == nil {
                    avgRating = CustomFormatter.formatFloat(float: CustomFormatter.formatAvgRating(float: i.avgRating))
                    if range.contains(date) {
                        selections.append(.lastReleased)
                    }
                } else {
                    selections.append(.announcement)
                }
            } else {
                realeseDate = String(localized: "comingSoon")
                selections.append(.announcement)
            }
            let snippetVM = SnippetViewModel(id: i.id, name: i.name, releaseDate: realeseDate, description: i.description, previewImage: i.previewImage, avgRating: avgRating, mainViewSelection: selections)
            snippetsVM.append(snippetVM)
        }
        
        // MARK: Перегон сериалов
        for i in ListViewModel.serials {
            var avgRating: String?
            var realeseDate: String?
            var seriesCount: String
            var selections: [MainViewSelections] = []
            
            (seriesCount, selections) = CustomFormatter.formatSeriesCountToString(seasons: i.seasons)
            if let date = i.releaseDate {
                realeseDate = CustomFormatter.formatDateToCustomString(unix: date)
                if realeseDate == nil {
                    avgRating = CustomFormatter.formatFloat(float: CustomFormatter.formatAvgRating(float: i.avgRating))
                } else {
                    if !selections.contains(.announcement) { // если по сезонам было определено, что это не анонс, а по дате выхода сериала это анонс, то это неправильные данные, скип
                        continue
                    }
                    if selections.contains(.completed) {
                        selections.removeAll(where: { $0 == .completed })
                    }
                }
            } else {
                realeseDate = String(localized: "comingSoon")
                selections.append(.announcement)
            }
            
            let snippetVM = SnippetViewModel(id: i.id, name: i.name, releaseDate: realeseDate, description: i.description, previewImage: i.previewImage, avgRating: avgRating, seriesCount: seriesCount, mainViewSelection: selections)
            snippetsVM.append(snippetVM)
        }
    }
    
    func getFilteredList(filterBy: MainViewSelections) -> [SnippetViewModel] {
        switch filterBy {
        case .mySelection:
            return snippetsVM.filter { $0.mainViewSelection.contains(.mySelection) }
        case .lastReleased:
            return snippetsVM.filter { $0.mainViewSelection.contains(.lastReleased) }
        case .ongoings:
            return snippetsVM.filter { $0.mainViewSelection.contains(.ongoings) }
        case .announcement:
            return snippetsVM.filter { $0.mainViewSelection.contains(.announcement) }
        case .completed:
            return snippetsVM.filter { $0.mainViewSelection.contains(.completed) }
        case .serials:
            return snippetsVM.filter { $0.mainViewSelection.contains(.serials) }
        case .films:
            return snippetsVM.filter { $0.mainViewSelection.contains(.films) }
        }
    }
}

extension ListViewModel {
    static let films: [Film] = [
        Film(id: "1", name: "biba1", releaseDate: 1699544372325, description: "bobaboba bobabobaboba bobabobabobab obabobabobaboba bobabobabobabobabo babobabobabobab obabobabobabobabobabo babobabobabobab obabobabobabobabobabobabobabobabobaboba", duration: 200, previewImage: "https://i.pinimg.com/236x/1b/9b/34/1b9b3430f3e89b95c22937d7c353737e1.jpg", avgRating: 5.0, ageRating: 15, moveTypes: [MovieType.action], author: "Alyosha"),
        Film(id: "2", name: "biba2", releaseDate: 920241212121, description: "bobaboba bobabobaboba bobabobabobab obabobabobaboba bobabobabobabobabo babobabobabobab obabobabobabobabobabo babobabobabobab obabobabobabobabobabobabobabobabobaboba", duration: 200, previewImage: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/JPEG_example_down.jpg/350px-JPEG_example_down.jpg", avgRating: 4.0, ageRating: 15, moveTypes: [MovieType.action], author: "Alyosha2"),
        Film(id: "3", name: "biba3", description: "boba3", duration: 200, previewImage: "https://img.freepik.com/premium-photo/dcim-101media-dji-0067-jpg_665346-20571.jpg", avgRating: 2.0, ageRating: 15, moveTypes: [MovieType.action], author: "Alyosha3"),
        Film(id: "4", name: "biba4", releaseDate: 1700315320619, description: "boba4", duration: 200, previewImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTt584rMTJ8Yqb6UxgqiV130sgnmDVEMSp8Bw&usqp=CAU", avgRating: 4.2,ageRating: 15, moveTypes: [MovieType.action], author: "Alyosha4"),
        Film(id: "5", name: "biba5", releaseDate: 1820241212121, description: "boba", duration: 200, previewImage: "https://www.codeproject.com/KB/GDI-plus/ImageProcessing2/img.jpg", avgRating: 2.5, ageRating: 15, moveTypes: [MovieType.action], author: "Alyosha"),
        Film(id: "6", name: "biba6", description: "boba2", duration: 200, previewImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvd0sBonCGb8bGoHNjUMOspgI3AoI_UR89oQ&usqp=CAU", avgRating: 3.3, ageRating: 15, moveTypes: [MovieType.action], author: "Alyosha2"),
        Film(id: "7", name: "biba7", releaseDate: 1699122213, description: "boba3", duration: 200, previewImage: "https://i.pinimg.com/236x/1b/9b/34/1b9b3430f3e89b95c22937d7c353737e.jpg", avgRating: 2.6, ageRating: 15, moveTypes: [MovieType.action], author: "Alyosha3"),
        Film(id: "8", name: "biba8", releaseDate: 1699123700619, description: "boba4", duration: 200, previewImage: "https://i.pinimg.com/236x/1b/9b/34/1b9b3430f3e89b95c22937d7c353737e.jpg", avgRating: 5.0, ageRating: 15, moveTypes: [MovieType.action], author: "Alyosha4"),
        Film(id: "9", name: "biba9", releaseDate: 1699123001619, description: "boba5", duration: 200, previewImage: "https://i.pinimg.com/236x/1b/9b/34/1b9b3430f3e89b95c22937d7c353737e.jpg", avgRating: 5.0, ageRating: 15, moveTypes: [MovieType.action], author: "Alyosha4")
    ]
    
    static let serials: [Serial] = [
        Serial(id: "1", name: "Крокодил Гена выходит на охоту", releaseDate: 1810241212121, description: "Гена шёл-шёл, шёл-шёл, так и не пришёл.", duration: 200, previewImage: "https://i.pinimg.com/236x/1b/9b/34/1b9b3430f3e89b95c22937d7c353737e.jpg", avgRating: 3.0, seasons: [], ageRating: 12, moveTypes: [.action], author: "Alyshka"),
        Serial(id: "2", name: "Мышь подкралась незаметно", releaseDate: 1699123761619, description: "Бежит, бежит, оп, упала", duration: 200, previewImage: "https://i.pinimg.com/236x/1b/9b/34/1b9b3430f3e89b95c22937d7c353737e.jpg", avgRating: 4.0, seasons: seasons1, ageRating: 12, moveTypes: [.action], author: "Alyshka"),
        Serial(id: "3", name: "Шарик взорвался", description: "Жалко конечно даааааа", duration: 200, previewImage: "https://i.pinimg.com/236x/1b/9b/34/1b9b3430f3e89b95c22937d7c353737e.jpg", avgRating: 5.0, seasons: seasons3, ageRating: 12, moveTypes: [.action], author: "Alyshka"),
        Serial(id: "4", name: "Винни полетел", description: "Бывает конечно даааааа", duration: 200, previewImage: "https://i.pinimg.com/236x/1b/9b/34/1b9b3430f3e89b95c22937d7c353737e.jpg", avgRating: 5.0, seasons: [], ageRating: 12, moveTypes: [.action], author: "Alyshka"),
        Serial(id: "5", name: "Фунтик толкает машину дядюшки Мокуса", releaseDate: 1823212121, description: "Тянет-потянет, вытащить так и не смог", duration: 200, previewImage: "https://i.pinimg.com/236x/1b/9b/34/1b9b3430f3e89b95c22937d7c353737e.jpg", avgRating: 5.0, seasons: seasons2, ageRating: 12, moveTypes: [.action], author: "Alyshka")
    ]
    
    static let seasons1: [Season] = [
        Season(id: "1", releaseDate: 1699123761620, description: "", seriesCount: 10),
        Season(id: "2", releaseDate: 1699123762619, description: "", seriesCount: 10),
        Season(id: "3", releaseDate: 1671023761619, description: "", seriesCount: 10)
    ]
    
    static let seasons2: [Season] = [
        Season(id: "1", releaseDate: 1823212121, description: "", seriesCount: 10)
    ]
    
    static let seasons3: [Season] = [
        Season(id: "2", releaseDate: 1699123761619, description: "", seriesCount: 10),
        Season(id: "4", releaseDate: 1699121514, description: "", seriesCount: 10)
    ]
}
