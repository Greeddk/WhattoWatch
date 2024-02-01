//
//  DetailViewController.swift
//  MovieTMDB
//
//  Created by Greed on 1/31/24.
//

import UIKit
import SnapKit

class DetailViewController: BaseViewController {
    
    let apiManager = TMDBAPIManager.shared
    
    let tableView = UITableView()
    var id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func callAPI() {
        
        apiManager.tvSeriesDetailCallRequest(url: <#T##String#>) { <#TVSeriesInfo#> in
            <#code#>
        }
        
        apiManager.castingCallRequest(url: <#T##String#>) { <#CastingInfo#> in
            <#code#>
        }
        
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MediaImageTableViewCell.identifier, for: indexPath)
            
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MediaOverviewTableViewCell.identifier, for: indexPath)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath)
            
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        } else if indexPath.section == 1 {
            return 300
        } else {
            return 500
        }
    }
}
