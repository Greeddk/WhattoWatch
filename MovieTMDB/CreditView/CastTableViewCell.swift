//
//  CastTableViewCell.swift
//  MovieTMDB
//
//  Created by Greed on 1/31/24.
//

import UIKit
import SnapKit

class CastTableViewCell: BaseTableViewCell {
    
    let actorImage = UIImageView()
    let nameLabel = UILabel()
    let roleNameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubviews([actorImage, nameLabel, roleNameLabel])
    }
    
    override func configureLayout() {
        actorImage.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(8)
            make.centerY.equalTo(contentView)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(contentView.frame.height / 3)
            make.leading.equalTo(actorImage.snp.trailing).offset(16)
        }
        
        roleNameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(nameLabel.snp.leading)
        }
    }
    
    override func configureView() {
        actorImage.layer.cornerRadius = 8
        
        nameLabel.font = .systemFont(ofSize: 16)
        nameLabel.textColor = .white
        roleNameLabel.font = .systemFont(ofSize: 13)
        roleNameLabel.textColor = .lightGray
    }

}
