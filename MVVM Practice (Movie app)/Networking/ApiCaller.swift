//
//  ApiCaller.swift
//  MVVM Practice (Movie app)
//
//  Created by Mustafa Nour on 20/02/2025.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case canNotParsedData
    case responseError
}
public class ApiCaller {
    static func getTrendingMovies
    //escaping keyWord is used to call this cluser after executing the function
    (completionHandeler: @escaping (_ result: Result<TrendingMoviesModel,NetworkError>) -> Void)
    {
        let urlString = NetworkConstants.shared.serverAddress + "trending/all/day?api_key=" + NetworkConstants.shared.ApiKey
        guard let url = URL(string: urlString) else {
            completionHandeler(.failure(.urlError))
            return
        }
        print("the url is : \(url) ")
        // MARK: - creating a dataTask for network Call
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            guard error == nil else {
                return completionHandeler(.failure(.urlError))
            }
            guard urlResponse is HTTPURLResponse else {
                completionHandeler(.failure(.responseError))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(TrendingMoviesModel.self, from: data! as Data)
                completionHandeler(.success(decodedData))
                print(decodedData)
            } catch {
                print(error)
            }
            }.resume()
        }
    /*
    // HINT: Add a new static function here to fetch details for a single movie by its ID.
    // Example: `static func getMovie(id: Int, completionHandler: @escaping (Result<Movie, NetworkError>) -> Void)`
    // This is crucial for retrieving favorited movies when you only have their IDs.
    // You'll need to define the URL for fetching a single movie by its ID, e.g., "movie/{id}".
    */
}
