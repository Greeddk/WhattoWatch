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

        let TVShowVC = UINavigationController(rootViewController: TVShowViewController())
        let MovieVC = UINavigationController(rootViewController: MovieViewController())
        
        TVShowVC.tabBarItem.image = UIImage(systemName: "play.tv")
        MovieVC.tabBarItem.image = UIImage(systemName: "movieclapper")
        
        TVShowVC.title = "TV"
        MovieVC.title = "영화"
        
        tabBar.barTintColor = .black //탭바 스크롤 할때 이게 없으면 흰색이 나옴
        tabBar.unselectedItemTintColor = .systemGray
        tabBar.backgroundColor = .black

        setViewControllers([TVShowVC, MovieVC], animated: true)
    }

}
