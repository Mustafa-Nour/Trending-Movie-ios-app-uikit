//
//  FavouritesViewModel.swift
//  MVVM Practice (Movie app)
//
//  Created by Mustafa Nour on 25/04/2025.
//

import Foundation

class FavouritesViewModel {
    var ViewModel =  MainViewModel()
    // HINT: This ViewModel should manage fetching and providing favorite movie data to the ViewController.
    // You'll need a property to hold the favorite movies, e.g., `var favourites: [Movie] = []`.
    // HINT: You might need a flag to manage loading state, e.g., `var isLoading = false`.
    var favourites: [Movie] = [] // Original state, will be populated via fetching
    //private init() {}
    
    // HINT: Implement a method to fetch favorite movies.
    // This method should:
    // 1. Get favorite movie IDs from `FavoritesManager.shared.getFavorites()`.
    // 2. Use `ApiCaller.getMovie(id: ...)` to fetch full `Movie` objects for each ID.
    // 3. Handle asynchronous network calls (e.g., using `DispatchGroup` or `async/await` if applicable).
    // 4. Update the `favourites` array with the fetched movies.
    // 5. Call a completion handler once all movies are fetched, typically for UI updates.

//    func GetMovieObject(id: Int ) -> Movie {
//        var favMovies = ViewModel.favMovies
//        for i in favMovies {
//            if i.id == id {
//                return 
//            }
//        }
//    }
    // HINT: Implement a method to get the number of favorite movies for the table view data source.
    func numberOfMovies () ->Int {
        // HINT: Return the count of favorite movies here.
        favourites.count // Original implementation
    }
    
    // HINT: Implement a method to provide a Movie object for a given index, used by the table view.
    // func movieAtIndex(_ index: Int) -> Movie? { ... }

    // HINT: These methods were part of previous logic but are now handled by `FavoritesManager` for persistence.
    // You can keep them if you need to manage the ViewModel's `favourites` array for UI purposes (e.g., adding/removing directly).
    func add(movie: Movie)
    {
        if !favourites.contains(where: {$0.id == movie.id}) {
            favourites.append(movie)
        }
    }
    func remove(movie: Movie) {
        favourites.removeAll { $0.id == movie.id}
    }

}


