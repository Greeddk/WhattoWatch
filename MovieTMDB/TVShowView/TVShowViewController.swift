//
//  HomeViewController.swift
//  MovieTMDB
//
//  Created by Greed on 1/30/24.
//

import UIKit
import Kingfisher
import SnapKit

class TVShowViewController: BaseViewController {
    
    let apiManager = TMDBAPIManager.shared
    
    let tableView = UITableView()
    
    let titleList = ["Top Rated", "Popular", "Trend"]
    
    var showList: [[TVShow]] = [[], [], []]
    var showLogo: [Int: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        callAPI()
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TVShowTableViewCell.self, forCellReuseIdentifier: TVShowTableViewCell.identifier)
        tableView.backgroundColor = .clear
    }
    
}

extension TVShowViewController {
    
    func callAPI() {
        
        let group = DispatchGroup()
        let roundLogoGroup = DispatchGroup()
        
        roundLogoGroup.enter()
        DispatchQueue.global().async(group: roundLogoGroup) {
            self.apiManager.tvShowCallRequest(url: TMDBAPIManager.APICase.topRatedTVURL) { show in
                self.showList[0] = show
                roundLogoGroup.leave()
            }
        }
        
        roundLogoGroup.notify(queue: .main) {
            self.showList[0].forEach {
                let id = $0.id
                let logoURL = "/tv/\(id)/images"
                self.apiManager.tvShowLogoCallRequest(url: logoURL) { show in
                    let url = show.logos[0].logo
                    self.showLogo[id] = url
                    
                }
            }
            
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.apiManager.tvShowCallRequest(url: TMDBAPIManager.APICase.popularTVURL) { show in
                self.showList[1] = show
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.apiManager.tvShowCallRequest(url: TMDBAPIManager.APICase.trendTVURL) { show in
                self.showList[2] = show
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
            print(self.showLogo)
        }
        
    }
    
}

extension TVShowViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TVShowTableViewCell.identifier, for: indexPath) as! TVShowTableViewCell
        
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.register(TVShowCollectionViewCell.self, forCellWithReuseIdentifier: TVShowCollectionViewCell.identifier)
        cell.collectionView.register(RoundLogoCollectionViewCell.self, forCellWithReuseIdentifier: RoundLogoCollectionViewCell.identifier)
        cell.collectionView.tag = indexPath.row
        cell.collectionView.reloadData()
        cell.collectionView.showsHorizontalScrollIndicator = false
        
        cell.sectionLabel.text = titleList[indexPath.row]
        
        return cell
    }
    
}

extension TVShowViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoundLogoCollectionViewCell.identifier, for: indexPath) as! RoundLogoCollectionViewCell
            
            let item = showList[collectionView.tag][indexPath.item]
            let poster = item.poster_path ?? ""
            let image = "https://image.tmdb.org/t/p/w500\(poster)"
            let url = URL(string: image)
            cell.roundImage.kf.setImage(with: url)
            
            guard let logo = showLogo[item.id] else { return cell }
            print(logo)
            let logoImage = "https://image.tmdb.org/t/p/w500\(logo)"
            let logoURL = URL(string: logoImage)
            cell.logoImage.kf.setImage(with: logoURL)
            
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVShowCollectionViewCell.identifier, for: indexPath) as! TVShowCollectionViewCell
            
            let item = showList[collectionView.tag][indexPath.item]
            let poster = item.poster_path ?? ""
            let image = "https://image.tmdb.org/t/p/w500\(poster)"
            let url = URL(string: image)
            cell.imageView.kf.setImage(with: url)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row != 0 {
            return UIScreen.main.bounds.height / 4 + 20
        } else {
            return 180
        }
    }
}
