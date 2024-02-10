//
//  SettingView.swift
//  MovieTMDB
//
//  Created by Greed on 2/10/24.
//

import UIKit
import SnapKit

class SettingView: BaseView {
    
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
