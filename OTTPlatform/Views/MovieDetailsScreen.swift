//
//  MovieDetailsScreen.swift
//  OTTPlatform
//
//  Created by Apple8 on 18/03/25.
//

import SwiftUI

struct MovieDetailsScreen: View {
    @State private var movieVM = MoviesDetailsViewModel()
    var body: some View {
        ZStack {
            if movieVM.isloading {
                ProgressView(.localizedKey("loading"))
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .foregroundStyle(.white)
                    .padding()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(spacing: 20) {
                            /* MARK: Here we are using the asset file incase if we are using api url for image we case use below mehtod
                             AsyncImageLoading(urlString: "", size: size)
                             */
                            Image(.movieDetail)
                                .resizableFit()
                            Image(.titleCard)
                                .resizableFit()
                                .containerRelativeFrame(.horizontal) { width, _ in
                                    return width / 1.8
                                }
                            if let movies = movieVM.movieDetail {
                                setupProductionDetails(["\(movies.releaseYear)", movies.genre, movies.duration, movies.rating])
                            }
                            Button {
                                
                            } label: {
                                HStack(spacing: 12) {
                                    Image(systemName: "play.fill")
                                        .foregroundStyle(.white)
                                    Text(.localizedKey("start_watching"))
                                        .foregroundStyle(.white)
                                }
                                .padding(12)
                                .frame(maxWidth: .infinity)
                                .roundedText(.subheadline, .bold)
                                .background(Color.gradientColor, in: .rect(cornerRadius: 8))
                                .padding(.horizontal)
                            }
                            InteractionControlScreen()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            if let movieDetail = movieVM.movieDetail {
                                ExpandableText(movieDetail.description, lineLimit: 3)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal)
                                    .onAppear {
                                        print(movieDetail.description)
                                    }
                                ProductionDetails(movieDetailsList: movieDetail.movieDetails, needTrailer: false)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                CastListScreen(castDetails: movieDetail.cast)
                            }
                            ListAndDetailsScreen(movieDetails: movieVM)
                                .padding(.bottom)
                        }
                        .padding(.bottom)
                }

            }
        }
        .backgroundModifier()
        .task {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                movieVM.loadMovieDetails()
            }
        }
    }
}

#Preview {
    MovieDetailsScreen()
}

extension MovieDetailsScreen {
    private func setupProductionDetails(_ details: [String]) -> some View {
        HStack {
            ForEach(details.indices, id: \.self) { index in
                Text(details[index])
                Circle()
                    .scaledToFit()
                    .frame(width: 5, height: 5)
                    .foregroundStyle(Color.gradientColor)
                    .opacity(index == details.count - 1 ? 0 : 1)
            }
        }
        .foregroundStyle(.white)
        .roundedText(.caption, .medium)
    }
}
