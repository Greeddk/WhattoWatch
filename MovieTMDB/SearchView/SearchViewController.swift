//
//  SearchViewController.swift
//  MovieTMDB
//
//  Created by Greed on 2/5/24.
//

import UIKit
import Kingfisher

class SearchViewController: BaseViewController {
    
    let mainView = SearchView()
    
    var showList: [TVShow] = [] {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        mainView.tableView.backgroundColor = .backColor
        mainView.tableView.rowHeight = UITableView.automaticDimension
        mainView.tableView.separatorStyle = .none
        mainView.searchBar.delegate = self
        
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        
        let item = showList[indexPath.item]
        if let poster = item.backdrop_path {
            let url = TMDBAPIManager.shared.imageBaseURL + poster
            cell.rectangleImage.kf.setImage(with: URL(string: url))
        } else {
            cell.rectangleImage.image = UIImage(systemName: "xmark")
        }
        cell.title.text = item.name
        
        return cell
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        TMDBSessionManager.shared.fetchSearchData(query: text) { show, error in
            if let show = show {
                self.showList = show
            } else {
                print(error)
            }
        }
        
        view.endEditing(true)
    }
    
}
