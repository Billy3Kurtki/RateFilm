//
//  SearchView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 10.11.2023.
//

import SwiftUI

struct CustomSearchView: View {
    @Binding var searchText: String
    @State var iconOffset = false
    @State var state = false
    @State var progress: CGFloat = 1.0
    @State var showTextFi = false
    var body: some View {
        ZStack(alignment: .trailing) {
            ZStack {
                RoundedRectangle(cornerRadius: Consts.cornerRadius, style: .continuous)
                RoundedRectangle(cornerRadius: Consts.cornerRadius, style: .continuous)
                    .stroke(lineWidth: Consts.lineWidth)
                    .foregroundStyle(state ? Color.customLightRed : .clear)
                if showTextFi {
                    TextField("Search", text: $searchText)
                        .padding(.horizontal)
                        .foregroundStyle(Color.customBlack)
                }
            }
            .frame(width: state ? Consts.widthFull : Consts.widthMini, height: Consts.height)
            .foregroundStyle(Color.customWhite)
            
            CustomSearchIcon(searchText: $searchText, progress: $progress, iconOffset: $iconOffset, state: $state, showTextFi: $showTextFi)
                
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    enum Consts {
        static var widthFull: CGFloat = 350
        static var widthMini: CGFloat = 40
        static var height: CGFloat = 40
        static var cornerRadius: CGFloat = 40
        static var lineWidth: CGFloat = 3
    }
}

#Preview {
    CustomSearchView(searchText: .constant(""))
}

struct CustomSearchIcon: View {
    @Binding var searchText: String
    @Binding var progress: CGFloat
    @Binding var iconOffset: Bool
    @Binding var state: Bool
    @Binding var showTextFi: Bool
    var body: some View {
        Button {
            if showTextFi {
                showTextFi = false
                searchText = ""
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation {
                    if !showTextFi && state {
                        showTextFi = true
                    }
                }
            }
            withAnimation {
                state.toggle()
            }
            if progress == 1.0 {
                withAnimation(.linear(duration: Consts.duration)) {
                    progress = 0.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation {
                        iconOffset.toggle()
                    }
                }
            } else {
                withAnimation {
                    iconOffset.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    withAnimation(.linear(duration: Consts.duration)) {
                        progress = 1.0
                    }
                }
            }
        } label: {
            VStack(spacing: 0) {
                Circle()
                    .trim(from: Consts.trimFrom, to: progress)
                    .stroke(lineWidth: Consts.lineWidth)
                    .rotationEffect(.degrees(Consts.rotationDegrees88))
                    .frame(width: Consts.circleWidth, height: Consts.circleHeight)
                    .padding()
                RoundedRectangle(cornerRadius: Consts.cornerRadius)
                    .frame(width: Consts.lineWidth, height: iconOffset ? 20 : 15)
                    .offset(y: Consts.offset)
                    .overlay {
                        RoundedRectangle(cornerRadius: Consts.cornerRadius)
                            .frame(width: Consts.lineWidth, height: iconOffset ? 20 : 15)
                            .rotationEffect(.degrees(iconOffset ? Consts.rotationDegrees80 : Consts.rotationDegrees0), anchor: .center)
                            .offset(y: Consts.offset)
                    }
                
            }
        }
        .rotationEffect(.degrees(Consts.rotationDegreesMinus40))
        .offset(x: iconOffset ? -5 : -3, y: iconOffset ? -5 : 2)
        .foregroundStyle(Color.customBlack)
        .frame(width: Consts.buttonWidth, height: Consts.buttonHeight)
    }
    
    enum Consts {
        static var duration: CGFloat = 0.5
        static var rotationDegrees88: CGFloat = 88
        static var rotationDegrees80: CGFloat = 80
        static var rotationDegrees0: CGFloat = 0
        static var rotationDegreesMinus40: CGFloat = -40
        static var offset: CGFloat = -17
        static var circleWidth: CGFloat = 15
        static var circleHeight: CGFloat = 15
        static var cornerRadius: CGFloat = 5
        static var lineWidth: CGFloat = 3
        static var trimFrom: CGFloat = 0.0
        static var buttonWidth: CGFloat = 40
        static var buttonHeight: CGFloat = 40
    }
}
