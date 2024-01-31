//
//  TVShowTableViewCell.swift
//  MovieTMDB
//
//  Created by Greed on 1/30/24.
//

import UIKit
import SnapKit

class TVShowTableViewCell: BaseTableViewCell {
    
    let sectionLabel = UILabel()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubview(sectionLabel)
        contentView.addSubview(collectionView)
    }
    
    override func configureView() {
        backgroundColor = .black
        collectionView.backgroundColor = .black
        sectionLabel.textColor = .white
        sectionLabel.font = .systemFont(ofSize: 14)
        sectionLabel.text = "text1"
    }
    
    override func configureLayout() {
        sectionLabel.snp.makeConstraints { make in
//            make.top.greaterThanOrEqualTo(contentView)
            make.horizontalEdges.top.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sectionLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
}

extension TVShowTableViewCell {
 
    static func collectionViewLayout() -> UICollectionViewLayout {
        
        let spacing: CGFloat = 8
        let cellWidth = UIScreen.main.bounds.width - spacing * 4
        let cellHeight = UIScreen.main.bounds.height - spacing * 4
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSize(width: cellWidth / 3, height: cellHeight / 4 - 20)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
}
