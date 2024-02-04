//
//  CastCollectionViewCell.swift
//  MovieTMDB
//
//  Created by Greed on 2/2/24.
//

import UIKit
import SnapKit

class CastCollectionViewCell: BaseCollectionViewCell {

    let actorImage = UIImageView()
    let nameLabel = UILabel()
    let roleNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        actorImage.clipsToBounds = true
        actorImage.layer.cornerRadius = actorImage.frame.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubviews([actorImage, nameLabel, roleNameLabel])
    }
    
    override func configureLayout() {
        actorImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(4)
            make.horizontalEdges.equalTo(contentView)
            make.size.equalTo(130)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(actorImage.snp.bottom).offset(2)
            make.centerX.equalTo(contentView)
        }
        
        roleNameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.centerX.equalTo(contentView)
        }
    }
    
    override func configureView() {
        nameLabel.font = .systemFont(ofSize: 16)
        nameLabel.textColor = .white
        roleNameLabel.font = .systemFont(ofSize: 13)
        roleNameLabel.textColor = .lightGray
    }
    
}
