//
//  DetailBaseView.swift
//  MovieTMDB
//
//  Created by Greed on 2/4/24.
//

import UIKit

class DetailBaseView: BaseView {
    
    let tableView = UITableView()
    
    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
}
