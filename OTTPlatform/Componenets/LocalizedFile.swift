//
//  LocalizedFile.swift
//  OTTPlatform
//
//  Created by Apple8 on 19/03/25.
//

import Foundation
import SwiftUI

extension LocalizedStringKey {
    static func localizedKey(_ key: String) -> LocalizedStringKey {
        return LocalizedStringKey(key)
    }
}

extension Double {
    func convertToString(_ isPlayed: Bool) -> String {
        return "\(self)" + (isPlayed ? " mins left" : " mins")
    }
}
