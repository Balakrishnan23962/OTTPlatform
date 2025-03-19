//
//  EpisodesListScreen.swift
//  OTTPlatform
//
//  Created by Apple8 on 18/03/25.
//

import SwiftUI

struct EpisodesListScreen: View {
    var episodesList: EpisodesList
    @State var currentSelectedSeason: SeasonList?
    var body: some View {
        LazyVStack {
            let season = episodesList.season
            LazyHStack {
                ForEach(season) { season in
                    Button {
                        withAnimation(.easeIn) {
                            currentSelectedSeason = season
                        }
                    } label: {
                        HStack {
                            Text(episodesList.title)
                            Text("\(season.seasonPart) ")
                            Image(systemName: "chevron.down")
                                .resizableFit()
                                .frame(width: 10, height: 10)
                        }
                        .padding(12)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black.opacity(0.5), lineWidth: 2)
                                .fill(season == currentSelectedSeason ? AnyShapeStyle(Color.gradientColor) :
                                AnyShapeStyle(Color.gray)) // Conditional fill
                        }
                        .padding([.leading, .bottom])
                        .roundedText(.subheadline, .bold)
                        .foregroundStyle(.white)
                    }
                }
            }
            .task {
                currentSelectedSeason = season.first
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            if let seasonPart = currentSelectedSeason {
                ForEach(seasonPart.episodes, id: \.id) { episode in
                    EpisodeDetails(episode: episode)
                        .id(episode.id)
                }
            }
        }
    }
}

#Preview {
    EpisodesListScreen(episodesList: MockDetails.shared.getRelatedList())
}

struct EpisodeDetails: View {
    var episode: EpisodesModel
    @State var value = 0.5
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                ZStack {
                    Image(.episode1)
                        .resizableFit()
                        .padding(.leading)
                    // here using container relative frame for specifying width, you can also alternate for vertical or if need both by specifying in the arguments
                        .containerRelativeFrame(.horizontal) { height, _ in
                            return height / 3
                        }
                    Image(systemName: "play.fill")
                        .resizableFit()
                        .padding(8)
                        .frame(width: 25, height: 25)
                        .foregroundStyle(.white)
                        .background {
                            Circle()
                                .stroke(Color.white, lineWidth: 3)
                                .fill(Color.black)
                        }
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text(episode.episodeName)
                        .roundedText(.headline, .bold)
                        .foregroundStyle(.white)
                    HStack {
                        if episode.isPlayed {
                            ProgressView(value: episode.progress)
                                .progressViewStyle(GradientProgressStyle(fill: Color.gradientColor, height: 4))
                                .containerRelativeFrame(.horizontal) { length, _ in
                                    return length / 4
                                }
                        }
                        let episodeTime = episode.episodeRemainingTime ?? episode.episodeTotalTime
                        Text(episode.isPlayed ? episodeTime.convertToString(episode.isPlayed) : episode.episodeTotalTime.convertToString(episode.isPlayed))
                            .roundedText(.footnote, .semibold)
                            .foregroundStyle(.gray)
                    }
                }
                .padding(.trailing)
            }
            Text(episode.episodeDescription)
                .roundedText(.footnote, .medium)
                .padding(.horizontal)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)

    }
}
