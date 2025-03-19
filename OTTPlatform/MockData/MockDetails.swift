//
//  MockDetails.swift
//  OTTPlatform
//
//  Created by Apple8 on 18/03/25.
//

import Combine

protocol GetMovieDetails {
    func getMovieDetails() -> AnyPublisher<SeriesDetailsModel, Error>
}

class MockDetails {
    static let shared = MockDetails()
}


extension MockDetails: GetMovieDetails {
    
    func getMovieDetails() -> AnyPublisher<SeriesDetailsModel, Error> {
        let model = SeriesDetailsModel(
            title: "Iron Man 3",
            releaseYear: 2011,
            genre: "Thriller",
            duration: "135 min",
            rating: "13+",
            thumbnailURL: "ironman.jpg",
            description: "After the events of The Avengers, Tony Stark wrestles with the consequences of his actions and his growing reliance on his Iron Man suits.When a powerful terrorist known as the Mandarin launches a devastating attack, Stark must go on a dangerous journey to reclaim his strength, uncover a deep conspiracy, and redefine what it truly means to be Iron Man. Facing his greatest challenge yet, he learns that the man makes the suit—not the other way around",
            productionHouse: "Columbia Pictures",
            director: "Peter Sohn",
            cast: getMockCast(),
            episodes: getRelatedList(),
            relatedMovies: getEpisodesForMovie(),
            movieDetails: getMovieDetails()
        )
        
        return Just(model)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getRelatedList() -> EpisodesList {
        return
            EpisodesList(title: "Season", season: [
                SeasonList(seasonPart: 1, episodes: getMockEpisodes()),
                SeasonList(seasonPart: 2, episodes: getMockEpisodes(2))
            ])
    }
    
    func getMovieDetails() -> MovieDetails {
        return  MovieDetails(detils:  [
            Details(title: "Production House", value: "Marvel Studios"),
            Details(title: "Director", value: "Shane Black"),
            Details(title: "Total Duration", value: "130 mins"),
            Details(title: "Release Date", value: "May 3, 2013"),
            Details(title: "Worldwide Box Office", value: "$1.2B")
        ], trailer: getMockEpisodes().first)
    }
    
    func getMockCast() -> [CastMember] {
        return [
            CastMember(name: "Robert Downey Jr.", role: "Iron Man", imageURL: "tony"),
            CastMember(name: "Gwyneth Paltrow", role: "Pepper Potts", imageURL: "castMember"),
            CastMember(name: "Don Cheadle", role: "War Machine", imageURL: "jeffry"),
            CastMember(name: "Ben Kingsley", role: "The Mandarin", imageURL: "tony"),
            CastMember(name: "Guy Pearce", role: "Aldrich Killian", imageURL: "jeffry")
        ]
    }
    
    func getMockEpisodes(_ season: Int = 1) -> [EpisodesModel] {
        switch season {
        case 1:
            return [
                EpisodesModel(episodeName: "Episode 1 - Attack on Stark",
                              episodeDescription: "Tony Stark's home is destroyed by a sudden assault from the Mandarin's forces.",
                              isPlayed: false, episodeTotalTime: 45, episodeRemainingTime: nil),
                
                EpisodesModel(episodeName: "Episode 2 - The Mechanic",
                              episodeDescription: "Stranded and presumed dead, Tony must rely on his intellect to rebuild and fight back.",
                              isPlayed: true, episodeTotalTime: 50, episodeRemainingTime: 20),
                
                EpisodesModel(episodeName: "Episode 3 - The Final Showdown",
                              episodeDescription: "Tony faces the real enemy behind the Mandarin and makes a life-changing decision.",
                              isPlayed: false, episodeTotalTime: 60, episodeRemainingTime: nil)
            ]
        case 2:
            return [
                EpisodesModel(episodeName: "Episode 1 - Arrival on Pandora", episodeDescription: "Jake Sully enters the Avatar program and meets the Na’vi.Jake Sully enters the Avatar program and meets the Na’vi.", isPlayed: false, episodeTotalTime: 45, episodeRemainingTime: nil),
                EpisodesModel(episodeName: "Episode 2 - Learning the Ways", episodeDescription: "Jake learns the customs of the Na’vi and struggles with his loyalties.", isPlayed: true, episodeTotalTime: 50, episodeRemainingTime: 30),
                EpisodesModel(episodeName: "Episode 3 - The Great Battle", episodeDescription: "Jake fights against the humans to protect Pandora.Jake Sully enters the Avatar program and meets the Na’vi.", isPlayed: false, episodeTotalTime: 60, episodeRemainingTime: nil)
            ]
        default: return []
        }
    }
    
    // Function to return episodes based on movie title
    func getEpisodesForMovie() -> EpisodesList {
        return EpisodesList(title: "Journey to Pandora", season: [
            SeasonList(seasonPart: 1, episodes: [
                EpisodesModel(episodeName: "Episode 1 - Arrival on Pandora", episodeDescription: "Jake Sully enters the Avatar program and meets the Na’vi.", isPlayed: false, episodeTotalTime: 45, episodeRemainingTime: nil),
                EpisodesModel(episodeName: "Episode 2 - Learning the Ways", episodeDescription: "Jake learns the customs of the Na’vi and struggles with his loyalties.", isPlayed: true, episodeTotalTime: 50, episodeRemainingTime: 45),
                EpisodesModel(episodeName: "Episode 3 - The Great Battle", episodeDescription: "Jake fights against the humans to protect Pandora.", isPlayed: false, episodeTotalTime: 60, episodeRemainingTime: nil)
            ])
        ])
    }

}
