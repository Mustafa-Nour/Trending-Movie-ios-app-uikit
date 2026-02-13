//
//  MainViewModel.swift
//  MVVM Practice (Movie app)
//
//  Created by Mustafa Nour on 19/02/2025.
//

import Foundation
class MainViewModel {
    
    var isLoading: observable<Bool> = observable(false)
    var dataSourse_TrendingViewModel: TrendingMoviesModel?
    var favMovies: [Movie] = []
    var movies: observable<[MovieCellViewModel]> = observable(nil)
    
    func numberOfSections() -> Int {
        1
    }
    func numberOfRowInSection(in section: Int) -> Int {
        self.dataSourse_TrendingViewModel?.results.count ?? 0
    }
    
    func getData() {
        if isLoading.value ?? true {
            return
        }
        
        isLoading.value = true
        ApiCaller.getTrendingMovies { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let data):
                print("Top Trending count: \(data.results.count)")
                self?.dataSourse_TrendingViewModel = data
                self?.mapCellData()
            case .failure(let error):
                print("ERROR : \(error.localizedDescription)")
            }
        }
    }
    
    func mapCellData() {
        movies.value = self.dataSourse_TrendingViewModel?.results.compactMap({MovieCellViewModel(movie: $0)})
    }
    
    func getMovieTitle(_ movie: Movie) ->String  {
        return movie.title ?? movie.name ?? "nonTiteld"
    }
    
    func retriveMovie(MovieId: Int) -> Movie? {
        guard let movie = dataSourse_TrendingViewModel?.results.first(where: {$0.id == MovieId}) else {
            return nil
         }
        favMovies.append(movie)
        return movie
        }
}
