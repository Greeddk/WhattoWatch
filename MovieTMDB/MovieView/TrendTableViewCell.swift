//
//  TrendTableViewCell.swift
//  MovieTMDB
//
//  Created by Greed on 1/25/24.
//

import UIKit
import Kingfisher

class TrendTableViewCell: BaseTableViewCell {
    
    let view = MediaCardView(type: .Movie)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubview(view)
    }
    
    override func configureLayout() {
        view.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
  
}

