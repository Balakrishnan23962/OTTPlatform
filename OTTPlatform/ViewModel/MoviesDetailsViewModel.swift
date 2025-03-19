//
//  MoviesDetailsViewModel.swift
//  OTTPlatform
//
//  Created by Apple8 on 18/03/25.
//

import Foundation
import SwiftUI
import Combine

@Observable
class MoviesDetailsViewModel {
    
    var movieDetail: SeriesDetailsModel?
    var moreLikeThis: EpisodesList?
    let getMovieDetails: GetMovieDetails
    var isloading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    var errorMessage: String?
    
    init(movieDetail: SeriesDetailsModel? = nil, getMovieDetails: GetMovieDetails = MockDetails.shared) {
        isloading = true
        self.movieDetail = movieDetail
        self.getMovieDetails = getMovieDetails
    }
    
    func loadMovieDetails() {
        getMovieDetails.getMovieDetails()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .finished: self?.isloading = false
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] result in
                self?.movieDetail = result
            }
            .store(in: &cancellables)
    }
}
