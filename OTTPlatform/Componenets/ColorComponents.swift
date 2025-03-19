//
//  ColorComponents.swift
//  OTTPlatform
//
//  Created by Apple8 on 18/03/25.
//

import Foundation
import SwiftUI

struct ColorComponents {
    static let linearGradientColor: LinearGradient = .init(colors: [.linearGradientStarting, .linearGradientEnd], startPoint: .leading, endPoint: .trailing)
}


extension Color {
    static var gradientColor: LinearGradient {
        ColorComponents.linearGradientColor
    }
}
