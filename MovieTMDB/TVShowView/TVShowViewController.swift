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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        tableView.rowHeight = UIScreen.main.bounds.height / 4 + 50
        tableView.register(TVShowTableViewCell.self, forCellReuseIdentifier: TVShowTableViewCell.identifier)
        tableView.backgroundColor = .clear
    }
    
}

extension TVShowViewController {
    
    func callAPI() {
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.apiManager.tvShowCallRequest(url: TMDBAPIManager.APICase.topRatedTVURL) { show in
                self.showList[0] = show
                group.leave()
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
        cell.collectionView.tag = indexPath.row
        cell.collectionView.reloadData()
        
        cell.sectionLabel.text = titleList[indexPath.row]
        
        return cell
    }
    
}

extension TVShowViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVShowCollectionViewCell.identifier, for: indexPath) as! TVShowCollectionViewCell
        
        let item = showList[collectionView.tag][indexPath.item]
        let poster = item.poster_path ?? ""
        let image = "https://image.tmdb.org/t/p/w500\(poster)"
        let url = URL(string: image)
        cell.imageView.kf.setImage(with: url)
        return cell
        
    }
    
}
