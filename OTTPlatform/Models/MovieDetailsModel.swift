//
//  MovieDetailsModel.swift
//  OTTPlatform
//
//  Created by Apple8 on 18/03/25.
//

import Foundation

struct SeriesDetailsModel: Identifiable {
    let id: UUID = UUID()
    let title: String
    let releaseYear: Int
    let genre: String
    let duration: String
    let rating: String
    let thumbnailURL: String?
    let description: String
    let productionHouse: String
    let director: String
    let cast: [CastMember]
    let episodes: EpisodesList?
    let relatedMovies: EpisodesList?
    let movieDetails: MovieDetails
}

struct EpisodesList: Identifiable {
    var id = UUID()
    var title: String
    var season: [SeasonList]
}

struct SeasonList: Identifiable, Equatable {
    static func == (lhs: SeasonList, rhs: SeasonList) -> Bool {
        return lhs.id == rhs.id
    }
    var id = UUID()
    var seasonPart: Int
    var episodes: [EpisodesModel]
}

struct MovieDetails: Identifiable {
    var id = UUID()
    var detils: [Details]
    var trailer: EpisodesModel?
}

struct Details: Identifiable {
    var id = UUID()
    var title: String
    var value: String
}

// MARK: - Cast Model
struct CastMember: Identifiable {
    let id: UUID = UUID()
    let name: String
    let role: String
    let imageURL: String
}
