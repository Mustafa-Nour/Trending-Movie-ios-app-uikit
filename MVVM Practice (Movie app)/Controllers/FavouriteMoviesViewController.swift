//
//  FavouriteMoviesViewController.swift
//  MVVM Practice (Movie app)
//
//  Created by Mustafa Nour on 25/04/2025.
//

import UIKit

class FavouriteMoviesViewController: UIViewController {

    @IBOutlet weak var MoviesTableView: UITableView!
    var cellDatasource: [MovieCellViewModel] = []
    var favViewModel = FavouritesViewModel()
    var CellDataSourse: [MovieCellViewModel] = []
    var ViewModel =  MainViewModel()
    override func viewDidLoad() {
        self.title = "Favourites"
        super.viewDidLoad()
        // HINT: Call `setupTableView()` here to initialize your table view.
        // Also, consider calling a method to fetch and display favorite movies.
        // Do any additional setup after loading the view.
    }

    // HINT: Implement `viewWillAppear` here to refresh the favorite movies list
    // every time this view controller is about to appear. This is important
    // to reflect changes made in other parts of the app.
    // override func viewWillAppear(_ animated: Bool) {
    //     super.viewWillAppear(animated)
    //     // Call your favorite movies fetching and table view reloading method here.
    // }

    func cinfigView() {
        setupTableView()
    }
    
    // HINT: You'll need a method here to fetch the actual favorite movie details.
    // This method should:
    // 1. Get favorite movie IDs from `FavoritesManager.shared.getFavorites()`.
    // 2. Use `ApiCaller.getMovie(id: ...)` to fetch full `Movie` objects for each ID.
    // 3. Update your `favViewModel.favourites` array with the fetched movies.
    // 4. Reload `MoviesTableView` on the main thread after fetching.
    
     //MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
extension FavouriteMoviesViewController: UITableViewDataSource, UITableViewDelegate {

    func setupTableView() {
        self.MoviesTableView.dataSource = self
        self.MoviesTableView.delegate = self
        self.MoviesTableView.backgroundColor = .clear
        self.registerCells()
    }
    
    func registerCells(){
        self.MoviesTableView.register(MainTableViewCell.register(), forCellReuseIdentifier: MainTableViewCell.identifire)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.MoviesTableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favViewModel.numberOfMovies()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
       1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = MoviesTableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifire, for: indexPath) as? MainTableViewCell else {
            return  UITableViewCell()
        }

        cell.setUpCell(viewModel: cellDatasource[indexPath.row]) // Original state, modify this line
        return cell
    }
}
    

