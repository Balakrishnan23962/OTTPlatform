//
//  EpisodesModel.swift
//  OTTPlatform
//
//  Created by Apple8 on 18/03/25.
//

import Foundation

struct EpisodesModel: Identifiable, Codable {
    var id = UUID()
    let episodeName: String
    let episodeDescription: String
    let isPlayed: Bool
    let episodeTotalTime: Double
    let episodeRemainingTime: Double?
    
    var progress: Double {
        guard let remaining = episodeRemainingTime else { return 0.0 }
        return 1.0 - (Double(remaining) / Double(episodeTotalTime))
    }
}
