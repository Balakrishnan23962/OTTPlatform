//
//  UserInteractionControl.swift
//  OTTPlatform
//
//  Created by Apple8 on 19/03/25.
//

import Foundation

enum UserInteractionControl: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    case addtoList
    case trailer
    case download
    case share
    
    var name: String {
        switch self {
        case .addtoList: "add_to_list"
        case .trailer: "trailer"
        case .download: "download"
        case .share: "share"
        }
    }
    
    var image: String {
        switch self {
        case .addtoList: "addToList"
        case .trailer: "trailer"
        case .download: "download"
        case .share: "share"
        }
    }
}

enum MovieControls: String, CaseIterable, Identifiable, Hashable {
    var id: String { self.rawValue }
    case episodes = "episodes"
    case moreLikeThis = "more_like_this"
    case movieDetails = "movie_details"
    
    var name: String {
        self.rawValue
    }
}
