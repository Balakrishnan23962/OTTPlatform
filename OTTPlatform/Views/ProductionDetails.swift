//
//  ProductionDetails.swift
//  OTTPlatform
//
//  Created by Apple8 on 18/03/25.
//

import SwiftUI

struct ProductionDetails: View {
    var movieDetailsList: MovieDetails?
    var needTrailer: Bool = true
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let movieDetailsList = movieDetailsList {
                if let trailer = movieDetailsList.trailer, needTrailer {
                    Text(.localizedKey("watch_trailer"))
                        .roundedText(.subheadline, .bold)
                        .padding(.leading)
                        .foregroundStyle(.white)
                    EpisodeDetails(episode: trailer)
                        .padding(.bottom)
                    Text(.localizedKey("production_details"))
                        .padding(.leading)
                        .roundedText(.subheadline, .semibold)
                        .foregroundStyle(.white)
                }
                let productionAndDirector = movieDetailsList.detils.prefix(2)
                ForEach(!needTrailer ? Array(productionAndDirector).indices : movieDetailsList.detils.indices, id: \.self) { index in
                    HStack(alignment: .center) {
                        Text(movieDetailsList.detils[index].title + ": ")
                            .foregroundStyle(.gray)
                        Text(movieDetailsList.detils[index].value)
                            .foregroundStyle(.white)
                    }
                    .roundedText(.caption, .semibold)
                }
                .padding([.horizontal])
            }
        }
    }
}

#Preview {
    ProductionDetails(movieDetailsList: MockDetails.shared.getMovieDetails())
}
