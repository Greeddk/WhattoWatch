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
    
    let mainView = DetailBaseView()
    
    let apiManager = TMDBAPIManager.shared
    
    var id: Int = 0
    var seriesInfo = TVSeriesInfo(backdrop_path: "", poster_path: "", name: "", original_name: "", overview: "", first_air_date: "", last_air_date: "", vote_average: 0, genres: [], number_of_episodes: 0, number_of_seasons: 0)
    var actorInfo = [Actor(name: "", profile_path: "", roles: [])]
    var recommendList: [TVShow] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI()
    }
    
    override func configureView() {
        UserDefaults.standard.setValue(false, forKey: "isMovie")
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(MediaImageTableViewCell.self, forCellReuseIdentifier: MediaImageTableViewCell.identifier)
        mainView.tableView.register(MediaOverviewTableViewCell.self, forCellReuseIdentifier: MediaOverviewTableViewCell.identifier)
        mainView.tableView.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.identifier)
        mainView.tableView.register(TVRecommendTableViewCell.self, forCellReuseIdentifier: TVRecommendTableViewCell.identifier)
        mainView.tableView.backgroundColor = .clear
        mainView.tableView.estimatedRowHeight = 240
        
        let popAllViewButton = UIBarButtonItem(title: "홈으로", style: .done, target: self, action: #selector(popAllViewButtonClicked))
        navigationItem.rightBarButtonItem = popAllViewButton
    }
    
    @objc
    func popAllViewButtonClicked() {
        navigationController?.popToRootViewController(animated: true)
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
        
        group.enter()
        apiManager.request(type: TVData.self, api: .tvRecommendURL(id: id)) { show in
            self.recommendList = show.results
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.mainView.tableView.reloadData()
        }
        
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MediaImageTableViewCell.identifier, for: indexPath) as! MediaImageTableViewCell
            cell.backImageView.kf.setImage(with: TMDBAPI.imageURL(imageURL: seriesInfo.backdrop_path ?? "").endpoint)
            cell.poster.kf.setImage(with: TMDBAPI.imageURL(imageURL: seriesInfo.poster_path).endpoint)
            cell.mediaName.text = seriesInfo.name
            cell.originName.text = seriesInfo.original_name
            if seriesInfo.genres.count > 1 {
                cell.genre.text = seriesInfo.genres[0].name + ", " + seriesInfo.genres[1].name
            } else {
                cell.genre.text = seriesInfo.genres.first?.name
            }
            cell.airDate.text = seriesInfo.airDate
            cell.numberOfSeasons.text = String(describing: seriesInfo.number_of_seasons) + "개의 시즌"
            cell.numberOfEpisodes.text = String(describing: seriesInfo.number_of_episodes) + "개의 에피소드"
            let rate = String(format: "%.1f", seriesInfo.vote_average)
            cell.rate.text = "★ \(rate)"
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MediaOverviewTableViewCell.identifier, for: indexPath) as! MediaOverviewTableViewCell
            if seriesInfo.overview != "" {
                cell.overviewLabel.text = seriesInfo.overview
            } else {
                cell.overviewLabel.text = "줄거리가 없습니다!"
            }
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as! CastTableViewCell
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.identifier)
            cell.collectionView.tag = indexPath.row
            cell.collectionView.backgroundColor = .clear
            cell.collectionView.reloadData()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TVRecommendTableViewCell.identifier, for: indexPath) as! TVRecommendTableViewCell
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.register(TVRecommendCollectionViewCell.self, forCellWithReuseIdentifier: TVRecommendCollectionViewCell.identifier)
            cell.collectionView.tag = indexPath.row
            cell.collectionView.backgroundColor = .clear
            cell.collectionView.reloadData()
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 240
        } else if indexPath.row == 1 {
            let text = seriesInfo.overview
            
            if text == "" {
                return 80
            } else {
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: CGFloat.greatestFiniteMagnitude))
                label.text = text
                label.numberOfLines = 0
                label.lineBreakMode = .byWordWrapping
                label.sizeToFit()
                return label.frame.height + 50
            }
            
        } else if indexPath.row == 2 {
            return 220
        } else {
            return 420
        }
    }
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 2 {
            return actorInfo.count
        } else {
            return recommendList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 2 {
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
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVRecommendCollectionViewCell.identifier, for: indexPath) as! TVRecommendCollectionViewCell
            
            let item = recommendList[indexPath.item]
            cell.view.configureCell(item: item)
            cell.view.genreLabel.text = ""
            cell.view.releasedateLabel.text = ""
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 3 {
            let vc = DetailViewController()
            vc.id = recommendList[indexPath.item].id
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
