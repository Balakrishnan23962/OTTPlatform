//
//  ListAndDetailsScreen.swift
//  OTTPlatform
//
//  Created by Apple8 on 18/03/25.
//

import SwiftUI

struct ListAndDetailsScreen: View {
    @Bindable var movieDetails: MoviesDetailsViewModel
    @State var tabs: MovieControls? = .episodes
    @State private var tabWidths: [MovieControls: CGFloat] = [:]
    @Namespace private var animation // Namespace for smooth animations
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                ForEach(MovieControls.allCases, id: \.id) { tab in
                    Button {
                        withAnimation(.spring()) {
                            tabs = tab
                        }
                    } label: {
                        VStack {
                            Text(.localizedKey(tab.name))
                                .roundedText(.subheadline, .bold)
                                .lineLimit(1)
                                .foregroundColor(tabs == tab ? .white : .gray)
                                .background {
                                    GeometryReader { proxy in
                                        Color.clear
                                            .onAppear {
                                                tabWidths[tab] = proxy.size.width
                                            }
                                    }
                                }
                            ZStack {
                                if tabs == tab {
                                    Rectangle()
                                        .foregroundStyle(tabs == tab ? AnyShapeStyle(Color.gradientColor) : AnyShapeStyle(Color.clear))
                                        .matchedGeometryEffect(id: "underline", in: animation)
                                } else {
                                    Rectangle()
                                        .foregroundColor(.clear)
                                }
                            }
                            .frame(width: tabWidths[tab] ?? 0, height: 3)
                        }
                    }
                    Spacer()
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
            LazyVStack {
                switch tabs {
                case .episodes:
                    if let episodes = movieDetails.movieDetail?.episodes {
                        EpisodesListScreen(episodesList: episodes)
                    }
                case .moreLikeThis:
                    if let episodes = movieDetails.movieDetail?.relatedMovies {
                        EpisodesListScreen(episodesList: episodes)
                    }
                case .movieDetails:
                    if let movieDetails = movieDetails.movieDetail?.movieDetails {
                        ProductionDetails(movieDetailsList: movieDetails, needTrailer: true)
                    }
                case .none:
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    ListAndDetailsScreen(movieDetails: MoviesDetailsViewModel())
}
