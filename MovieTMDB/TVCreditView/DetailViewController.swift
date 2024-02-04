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
    
    var seriesInfo = TVSeriesInfo(backdrop_path: "", poster_path: "", name: "", overview: "")
    var actorInfo = [Actor(name: "", profile_path: "", roles: [])]
    var recommendList = [TVShow(id: 0, name: "", poster_path: nil)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI()
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
//        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func callAPI() {
        
        let group = DispatchGroup()

        group.enter()
        apiManager.request(type: TVSeriesInfo.self, api: .tvSeriesDetailURL(id: id)) { series in
            self.seriesInfo = series
            group.leave()
        }
        
        group.enter()
        apiManager.request(type: CastingInfo.self, api: .tvCreditURL(id: id)) { [self] actors in
            actorInfo = actors.cast
            group.leave()
        }
        
//        group.enter()
//        apiManager.request(type: TVShow.self, api: .recommendTVURL(id: id)) { show in
//            self.recommendList = show.
//            group.leave()
//        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
        
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MediaImageTableViewCell.identifier, for: indexPath) as! MediaImageTableViewCell
            cell.backImageView.kf.setImage(with: TMDBAPI.imageURL(imageURL: seriesInfo.backdrop_path ?? "").endpoint)
            cell.poster.kf.setImage(with: TMDBAPI.imageURL(imageURL: seriesInfo.poster_path).endpoint)
            cell.mediaName.text = seriesInfo.name
            
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MediaOverviewTableViewCell.identifier, for: indexPath) as! MediaOverviewTableViewCell
            cell.overviewLabel.text = seriesInfo.overview
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as! CastTableViewCell
            
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.identifier)
            cell.collectionView.tag = indexPath.row
            cell.collectionView.backgroundColor = .clear
            
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 240
        } else if indexPath.section == 1 {
            return 200
        } else if indexPath.section == 2 {
            return 0
        } else {
            return 240
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
        if let url = item.profile_path {
            let url = TMDBAPI.imageURL(imageURL: url).endpoint
            cell.actorImage.kf.setImage(with: url)
        } else {
            cell.actorImage.image = UIImage(systemName: "person")
        }
        cell.nameLabel.text = item.name
        cell.roleNameLabel.text = item.roles.first?.character
        
        return cell
    }
    
    
}
