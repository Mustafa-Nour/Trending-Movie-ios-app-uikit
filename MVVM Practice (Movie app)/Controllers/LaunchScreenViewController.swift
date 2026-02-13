//
//  LaunchScreenViewController.swift
//  MVVM Practice (Movie app)
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    // Logo image view
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "last")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(logoImageView)
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
}

extension LaunchScreenViewController {
    
    // MARK: -  Layout
    func layout() {
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        logoImageView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        logoImageView.alpha = 0
    }
    
    // MARK: -  animation
    func animate() {
        UIView.animate(withDuration: 0.8,
                       delay: 0.2,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut,
                       animations: {
            self.logoImageView.transform = .identity
            self.logoImageView.alpha = 1.0
        }) { _ in
            // Wait then transition
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.transitionToMainApp()
            }
        }
    }
    
    // MARK: -  Transition
    private func transitionToMainApp() {
        guard let window = UIApplication.shared.windows.first else { return }
        
        // Setup TabBar
        let mainNavController = UINavigationController(rootViewController: MainViewController())
        mainNavController.tabBarItem = UITabBarItem(title: "Top Trending Movies 🔥🎥",
                                                   image: UIImage(systemName: "film"),
                                                   tag: 0)
        
        let favController = FavouriteMoviesViewController(nibName: "FavouriteMoviesViewController", bundle: nil)
        favController.tabBarItem = UITabBarItem(title: "Favourites",
                                               image: UIImage(systemName: "heart.fill"),
                                               tag: 1)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainNavController, favController]
        
        // Transition to main app
        UIView.transition(with: window,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
            window.rootViewController = tabBarController
        }, completion: nil)
    }
}
