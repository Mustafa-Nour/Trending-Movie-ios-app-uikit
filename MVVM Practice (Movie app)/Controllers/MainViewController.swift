//
//  MainViewController.swift
//  MVVM Practice (Movie app)
//
//  Created by Mustafa Nour on 17/02/2025.
//

import UIKit
import UserNotifications

 class MainViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
     @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
     //viewModel
     var ViewModel: MainViewModel = MainViewModel()
     // variables
     var CellDataSourse: [MovieCellViewModel] = []
    override func viewDidLoad() {
        cinfigureView()
        //notifications
       
        super.viewDidLoad()
    }
     override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         ViewModel.getData()

     }
     
     func cinfigureView() {
         setupTableView()
         
         self.title = "Top Trending Movies 🔥🎥"
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 24),
                .foregroundColor: UIColor.label
            ]
            navigationController?.navigationBar.titleTextAttributes = attributes
//            self.view.backgroundColor
         ViewModel.isLoading.bind { [weak self] isLoading in
             guard let self = self , let isLoading = isLoading else{
                 return
             }
             DispatchQueue.main.async {
                 if isLoading {
                     self.activityIndicator.startAnimating()
                 } else {
                     self.activityIndicator.stopAnimating()
                     self.activityIndicator.hidesWhenStopped = true
                 }
             }
             ViewModel.movies.bind { [weak self] movies in
                 guard let self = self,
                       let movies = movies else {
                     return
                 }
                 self.CellDataSourse = movies
                 self.reloadTableView()
             }
         }
     }
     
     func openMovieDetails(MovieID: Int){
         guard let movie = ViewModel.retriveMovie(MovieId: MovieID) else {
             return
         }
         let detailsViewModel = DetailsViewModel(movie: movie)
         let detailViewController = MovieDetailsViewController(viewModel: detailsViewModel)
         DispatchQueue.main.async {
             self.navigationController?.pushViewController(detailViewController, animated: true)
         }
         func userNotificationCenter(_ center: UNUserNotificationCenter,
                                     didReceive response: UNNotificationResponse,
                                     withCompletionHandler completionHandler: @escaping () -> Void) {
             _ = response.notification.request.content.userInfo
            
             completionHandler()
         }

     }
}

// MARK: - TableView Extention
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.registerCells()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func registerCells() {
        self.tableView.register(MainTableViewCell.register(), forCellReuseIdentifier: MainTableViewCell.identifire)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        ViewModel.numberOfSections()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ViewModel.numberOfRowInSection(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifire, for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        cell.setUpCell(viewModel: CellDataSourse[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieId = CellDataSourse[indexPath.row].id
        self.openMovieDetails(MovieID: movieId)
        
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let movieId = CellDataSourse[indexPath.row].id
//        self.openDetails(movieId: movieId)
//    }

}
