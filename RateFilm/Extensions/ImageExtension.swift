//
//  ImageExtension.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 25.10.2023.
//

import SwiftUI

extension Image {
    func imageIconModifier(width: CGFloat, height: CGFloat) -> some View {
        self
            .renderingMode(.original)
            .resizable()
            .frame(width: width, height: height)
            .shadow(color: Color(red: 0,
                    green: 0, blue: 0, opacity: 0.3),
                    radius: 3, x: 2, y: 2)
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}
