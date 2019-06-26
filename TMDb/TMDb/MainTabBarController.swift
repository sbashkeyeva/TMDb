//
//  ViewController.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/20/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    func setupTabBar(){
        let moviesController = createNavController(vc: MoviesViewController())
        moviesController.tabBarItem.title = "MOVIES"
        let genresViewController = GenresViewController()
        genresViewController.viewModel = GenresViewModel()
        let genresController = createNavController(vc: genresViewController)
        genresController.tabBarItem.title = "GENRES"
        viewControllers = [moviesController,genresController,]
        guard let items = tabBar.items else {
            return
        }
        for item in items {
            let fontAttribute = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 30)]
            item.setTitleTextAttributes(fontAttribute, for: .normal)
        }
    }

}
extension UITabBarController {
    func createNavController(vc: UIViewController) ->UINavigationController{
        let viewController = vc
        let navController = UINavigationController(rootViewController: viewController)
        return navController
    }
}

