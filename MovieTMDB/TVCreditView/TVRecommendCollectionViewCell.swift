//
//  TVRecommendCollectionViewCell.swift
//  MovieTMDB
//
//  Created by Greed on 2/4/24.
//

import UIKit
import SnapKit

class TVRecommendCollectionViewCell: BaseCollectionViewCell {
    
    let view = MediaCardView(type: .TV)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
