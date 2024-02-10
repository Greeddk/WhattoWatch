//
//  BaseCollectionViewCell.swift
//  MovieTMDB
//
//  Created by Greed on 1/31/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell, CodeBase {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .backColor
        configureHierarchy()
        configureView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() { }
    
    func configureView() { }
    
    func configureLayout() { }
}
