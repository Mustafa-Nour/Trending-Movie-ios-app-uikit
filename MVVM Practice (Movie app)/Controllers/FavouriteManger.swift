import Foundation

class FavoritesManager {
    private let favoritesKey = "favoriteMovies"
    static let shared = FavoritesManager()
    static var favourites: [Int] = []
    private init() {
        Self.favourites = getFavorites()
    }
    
    // Get all favorite movies
    func getFavorites() -> [Int] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey) else {
            return []
        }
        
        do {
            let favorites = try JSONDecoder().decode([Int].self, from: data)
            return favorites
        } catch {
            print("Error decoding favorites: \(error)")
            return []
        }
    }
    
    // Save favorites to UserDefaults
    private func saveFavorites(_ favorites: [Int]) {
        do {
            let data = try JSONEncoder().encode(favorites)
            Self.favourites = favorites
            UserDefaults.standard.set(data, forKey: favoritesKey)
            print("DEBUG: Favorites saved: \(favorites)")
        } catch {
            print("Error encoding favorites: \(error)")
        }
    }
    
    // Add a movie to favorites (toggle)
    func toggleMovie(_ movieId: Int) {
        var favorites = getFavorites()
        
        // Only add if not already in favorites
        if !favorites.contains(movieId) {
            favorites.append(movieId)
            print("DEBUG: Added movie ID \(movieId) to favorites.")
        } else {
            favorites.removeAll { $0 == movieId }
            print("DEBUG: Removed movie ID \(movieId) from favorites.")
        }
        saveFavorites(favorites)
    }
    
    // Check if a movie is in favorites
    func isFavorite(_ movieId: Int) -> Bool {
        let favorites = getFavorites()
        print("DEBUG: Checking if \(movieId) is favorite. Current favorites: \(favorites)")
        return favorites.contains(movieId)
    }
    
    // get favourite Movies
   //func getMovies(movieID: Int )
}
