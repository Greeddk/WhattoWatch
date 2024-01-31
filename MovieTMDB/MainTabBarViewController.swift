//
//  MainTabBarViewController.swift
//  MovieTMDB
//
//  Created by Greed on 1/30/24.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = UINavigationController(rootViewController: TVShowViewController())
        let trendVC = UINavigationController(rootViewController: MovieViewController())
        
        homeVC.tabBarItem.image = UIImage(systemName: "play.tv")
        trendVC.tabBarItem.image = UIImage(systemName: "movieclapper")
        
        homeVC.title = "TV"
        trendVC.title = "영화"
        
        tabBar.unselectedItemTintColor = .systemGray
        tabBar.barTintColor = .black
        
        setViewControllers([homeVC, trendVC], animated: true)
    }

}
