//
//  MovieDetailsViewController.swift
//  MVVM Practice (Movie app)
//
//  Created by Mustafa Nour on 19/04/2025.
//

import UIKit
import SDWebImage
import UserNotifications

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    var favouriteMovies = [Movie]()
    // HINT: This property should track the favorite status of the current movie.
    // Initialize it by checking with `FavoritesManager`.
    var isFavorited: Bool
    private var favButton: UIBarButtonItem
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //view Model
    var viewModel: DetailsViewModel
    init(viewModel: DetailsViewModel){
        self.viewModel = viewModel
        self.isFavorited = FavoritesManager.shared.isFavorite(viewModel.movieId)
        
        let imageName = isFavorited ? "heart.fill" : "heart"
        self.favButton = UIBarButtonItem(image: UIImage(systemName: imageName), style: .plain, target: nil, action: nil)
        
        super.init(nibName: "MovieDetailsViewController", bundle: nil)
        favButton.target = self
        favButton.action = #selector(didTapFav)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //noification premtion
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print("Notification permission denied: \(error?.localizedDescription ?? "No error")")
            }
        }
        configView()
    }
    @objc func didTapFav() {
        isFavorited.toggle()
        let imageName = isFavorited ? "heart.fill" : "heart"
        favButton.image = UIImage(systemName: imageName)
        FavoritesManager.shared.toggleMovie(viewModel.movieId)
        print("fav is : \(FavoritesManager.shared.getFavorites())")
    }
    func configView() {
        self.title = "MovieDetails"
        
        // HINT: Original background color for the view was default. To revert, remove this line.
        view.backgroundColor = .black
        
        // HINT: Original TitleLabel settings. To revert, remove these lines.
        TitleLabel.text = viewModel.movieTitle
        TitleLabel.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        TitleLabel.textColor = .white
        TitleLabel.numberOfLines = 0
        
        // HINT: Original descriptionLabel settings. To revert, remove these lines.
        descriptionLabel.text = viewModel.movieDesc
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        descriptionLabel.textColor = .lightGray
        descriptionLabel.numberOfLines = 0
        
        // HINT: Original movieImageView settings. To revert, remove these lines.
        movieImageView.sd_setImage(with: viewModel.movieImage)
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.clipsToBounds = true
        movieImageView.layer.cornerRadius = 12
        movieImageView.layer.borderWidth = 1
        movieImageView.layer.borderColor = UIColor.darkGray.cgColor
        
        navigationItem.rightBarButtonItem = favButton
        
    }
    
}
