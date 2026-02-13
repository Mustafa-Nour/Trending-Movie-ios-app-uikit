//
//  NetworkConstants.swift
//  MVVM Practice (Movie app)
//
//  Created by Mustafa Nour on 20/02/2025.
//

import Foundation

class NetworkConstants {
    public static var shared: NetworkConstants = NetworkConstants()
    
    private init () {
        
    }
    
    public var ApiKey: String {
        get {
            return "f5f471ce51165d66c55453662ead8ccd"
        }
    }
    
    public var serverAddress: String {
        get {
            return "https://api.themoviedb.org/3/"
        }
    }
    
    public var imageServerAddress: String {
        get {
            return "https://image.tmdb.org/t/p/w500/"
        }
    }
    
}
