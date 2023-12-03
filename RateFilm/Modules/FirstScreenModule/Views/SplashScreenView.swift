//
//  SplashScreenView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 14.11.2023.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var size = Consts.sizeStart
    @State private var opacity = Consts.opacityStart
    @State private var rotation: CGFloat = Consts.rotationStart
    @Binding var isActive: Bool
    
    var body: some View {
        VStack {
            VStack {
                Image(AppConsts.appIcon)
                    .resizable()
                    .frame(width: Consts.iconWidth, height: Consts.iconHeight)
                    .clipShape(Capsule())
                    .rotationEffect(.degrees(rotation))
                Text(AppConsts.appName)
                    .font(.title.bold())
                    .foregroundStyle(Color.customBlack)
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeOut(duration: Consts.animationDuration)) {
                    self.size = Consts.sizeFinish
                    self.opacity = Consts.animateIsRunningOpacity
                    self.rotation = Consts.rotationFinish
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + Consts.animationDelay) {
                withAnimation {
                    self.isActive = true
                    self.opacity = Consts.animateIsFinishOpacity
                }
            }
        }
    }
    
    enum Consts {
        static var sizeStart: CGFloat = 0.8
        static var sizeFinish: CGFloat = 1
        static var opacityStart: Double = 0.5
        static var animateIsRunningOpacity: Double = 0.9
        static var animateIsFinishOpacity: Double = 0
        static var rotationStart: CGFloat = -30
        static var rotationFinish: CGFloat = 0
        static var animationDelay: Double = 2.0
        static var iconWidth: CGFloat = 150
        static var iconHeight: CGFloat = 150
        static var animationDuration: Double = 2.0
    }
}
