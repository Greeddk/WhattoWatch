//
//  RoundLogoCollectionViewCell.swift
//  MovieTMDB
//
//  Created by Greed on 1/31/24.
//

import UIKit
import SnapKit

class RoundLogoCollectionViewCell: BaseCollectionViewCell {
    
    let roundImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = view.frame.width / 2
        return view
    }()
    let logoImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func layoutSubviews() {
        roundImage.clipsToBounds = true
        roundImage.layer.cornerRadius = roundImage.frame.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        addSubviews([roundImage, logoImage])
    }
    
    override func configureView() {
        logoImage.contentMode = .scaleAspectFit
    }
    
    override func configureLayout() {
        roundImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(50)
            make.size.equalTo(120)
        }
        
        logoImage.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.horizontalEdges.equalTo(roundImage).inset(10)
            make.bottom.equalTo(roundImage.snp.bottom)
        }
    }
    
}
