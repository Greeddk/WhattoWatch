//
//  ViewController.swift
//  MovieTMDB
//
//  Created by Greed on 1/25/24.
//

import UIKit

class MovieViewController: BaseViewController {
    
    let tableView = UITableView()
    
    var movieList: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "isMovie")
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    override func configureView() {
        callRequest()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 400
        tableView.separatorStyle = .none
        
        tableView.register(TrendTableViewCell.self, forCellReuseIdentifier: TrendTableViewCell.identifier)
    }

}

extension MovieViewController {
    
    private func callRequest() {
        TMDBAPIManager.shared.request(type: MovieRank.self, api: .movieTrendURL) { movie in
            self.movieList = movie.results
        }

    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.identifier, for: indexPath) as! TrendTableViewCell
        
        cell.view.configureCell(item: movieList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

