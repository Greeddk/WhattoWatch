//
//  MediaCollectionViewCell.swift
//  MovieTMDB
//
//  Created by Greed on 1/30/24.
//

import UIKit
import SnapKit

class TVShowCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubviews([imageView])
    }
    
    override func configureView() {
        imageView.image = UIImage(systemName: "star")
        imageView.contentMode = .scaleAspectFill
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }

}
