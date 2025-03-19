//
//  GradientProgressViewStyle.swift
//  OTTPlatform
//
//  Created by Apple8 on 18/03/25.
//

import Foundation
import SwiftUI

struct GradientProgressStyle<Background: ShapeStyle>: ProgressViewStyle {
    var fill: Background
    var cornerRadius: CGFloat = 4
    var height: CGFloat = 8
    var animation: Animation = .spring()
    init(fill: Background, height: CGFloat) {
        self.fill = fill
        self.cornerRadius = height / 2
        self.height = height
    }
    
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        VStack {
            ZStack(alignment: .topLeading) {
                GeometryReader { geo in
                    Rectangle().fill(.gray.opacity(0.5))
                        .overlay(
                            Capsule(style: .circular).fill(fill).frame(maxWidth: geo.size.width * CGFloat(fractionCompleted))
                                .animation(animation, value: fractionCompleted)
                            ,alignment: .leading)
                   
                }
            }
            .frame(height: height)
            .cornerRadius(cornerRadius)
        }
    }
}
