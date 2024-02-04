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
        
        //        self.navigationController?.isNavigationBarHidden = true
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
        let imageGroup = DispatchGroup()
        
        group.enter()
        imageGroup.enter()
        apiManager.request(type: TVRank.self, api: .tvTopRatedURL) { show in
            self.showList[0] = show.results
            group.leave()
            imageGroup.leave()
        }
        
        
        group.enter()
        imageGroup.notify(queue: .main) {
            self.showList[0].forEach {
                group.enter()
                let id = $0.id
                self.apiManager.request(type: ShowImage.self, api: .tvLogoURL(id: id)) { show in
                    self.showLogo[id] = show.logos.first?.logo
                    group.leave()
                }
            }
            group.leave()
        }
        
        group.enter()
        apiManager.request(type: TVRank.self, api: .tvPopularURL) { show in
            self.showList[1] = show.results
            group.leave()
        }
        
        group.enter()
        apiManager.request(type: TVRank.self, api: .tvTrendURL) { show in
            self.showList[2] = show.results
            group.leave()
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
        cell.collectionView.register(RoundLogoCollectionViewCell.self, forCellWithReuseIdentifier: RoundLogoCollectionViewCell.identifier)
        cell.collectionView.tag = indexPath.row
        cell.collectionView.reloadData()
        cell.collectionView.showsHorizontalScrollIndicator = false
        
        cell.sectionLabel.text = titleList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 180
        } else {
            return 240
        }
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
            let logoImage = "https://image.tmdb.org/t/p/w154\(logo)"
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.id = showList[collectionView.tag][indexPath.item].id
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
