//
//  BackgroundModifier.swift
//  OTTPlatform
//
//  Created by Apple8 on 18/03/25.
//

import SwiftUI

extension View {
    func backgroundModifier() -> some View {
        self.modifier(BackgroundModifier(color: .background))
    }
    
    // customizing font for using serif text or we can use rounded type text also, change the font desing to achieve that
    func roundedText(_ font: Font, _ weight: Font.Weight) -> some View {
        self
            .font(font)
            .fontWeight(weight)
            .fontDesign(.rounded)
    }
}

extension Image {
    func resizableFit() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
}

struct BackgroundModifier: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        ZStack {
            color
            content
        }
        .ignoresSafeArea()
    }
}

