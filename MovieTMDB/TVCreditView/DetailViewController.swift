//
//  DetailViewController.swift
//  MovieTMDB
//
//  Created by Greed on 1/31/24.
//

import UIKit
import SnapKit
import Kingfisher

class DetailViewController: BaseViewController {
    
    let apiManager = TMDBAPIManager.shared
    
    let tableView = UITableView()
    var id: Int = 0
    
    var seriesInfo = TVSeriesInfo(backdrop_path: "", poster_path: "", name: "", overview: "") {
        didSet {
            tableView.reloadData()
        }
    }
    var actorInfo = [Actor(name: "", profile_path: "", roles: [])]
    var recommendList = [TVShow(id: 0, name: "", poster_path: nil)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(id)
        callAPI(id: id)
    }

    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MediaImageTableViewCell.self, forCellReuseIdentifier: MediaImageTableViewCell.identifier)
        tableView.register(MediaOverviewTableViewCell.self, forCellReuseIdentifier: MediaOverviewTableViewCell.identifier)
        tableView.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.identifier)
        tableView.backgroundColor = .clear
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func callAPI(id: Int) {
        
        let group = DispatchGroup()
        
        TMDBAPIManager.id = self.id
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.apiManager.tvSeriesDetailCallRequest(url: TMDBAPIManager.APICase.seriesDetailURL ) { series in
                self.seriesInfo = series
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.apiManager.castingCallRequest(url: TMDBAPIManager.APICase.creditTVURL) { actor in
                self.actorInfo = actor.cast
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.apiManager.tvShowCallRequest(url: TMDBAPIManager.APICase.recommendTVURL) { show in
                self.recommendList = show
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
            print(self.actorInfo)
        }
        
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MediaImageTableViewCell.identifier, for: indexPath) as! MediaImageTableViewCell
            let baseURL = apiManager.imageBaseURL
            cell.backImageView.kf.setImage(with: URL(string: baseURL + seriesInfo.backdrop_path))
            cell.poster.kf.setImage(with: URL(string: baseURL + seriesInfo.poster_path))
            cell.mediaName.text = seriesInfo.name
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MediaOverviewTableViewCell.identifier, for: indexPath) as! MediaOverviewTableViewCell
            
            cell.overviewLabel.text = seriesInfo.overview
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as! CastTableViewCell
            
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.identifier)
            cell.collectionView.tag = indexPath.row
            cell.collectionView.isScrollEnabled = true
            
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 240
        } else if indexPath.row == 1 {
            return 200
        } else {
            return 250
        }
    }
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actorInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier, for: indexPath) as! CastCollectionViewCell
        
        let item = actorInfo[indexPath.item]
        let baseURL = apiManager.imageBaseURL
        if let imageURL = item.profile_path {
            cell.actorImage.kf.setImage(with: URL(string: baseURL + imageURL))
        } else {
            cell.actorImage.image = UIImage(systemName: "person")
        }
        cell.nameLabel.text = item.name
        cell.roleNameLabel.text = item.roles.first?.character
        
        return cell
    }
    
    
}
