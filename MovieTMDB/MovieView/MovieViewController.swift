//
//  ViewController.swift
//  MovieTMDB
//
//  Created by Greed on 1/25/24.
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet var movieTableView: UITableView!
    
    var movieList: [Movie] = [] {
        didSet {
            movieTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
    }

}

extension MovieViewController {
    
    private func setTableView() {
        
        callRequest()
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        movieTableView.rowHeight = UIScreen.main.bounds.height / 2
        movieTableView.separatorStyle = .none
        
        let xib = UINib(nibName: TrendTableViewCell.identifier, bundle: nil)
        movieTableView.register(xib, forCellReuseIdentifier: TrendTableViewCell.identifier)
    }
    
    private func setUI() {
        
        
    }
    
    private func callRequest() {
        
        TMDBAPIManager().movieCallRequest(url: TMDBAPIManager.APICase.trendMovieURL, completionHandler: { value in
            self.movieList = value
            print(self.movieList)
        })
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.identifier, for: indexPath) as! TrendTableViewCell
        
        cell.configureCell(item: movieList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

