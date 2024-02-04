//
//  TVRecommendTableViewCell.swift
//  MovieTMDB
//
//  Created by Greed on 2/4/24.
//

import UIKit
import SnapKit

class TVRecommendTableViewCell: BaseTableViewCell {
    
    let rowTitle = UILabel()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubviews([rowTitle, collectionView])
    }
    
    override func configureLayout() {
        rowTitle.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(2)
            make.leading.equalTo(contentView).offset(16)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(rowTitle.snp.bottom)
            make.horizontalEdges.bottom.equalTo(contentView)
        }
    }
    
    override func configureView() {
        rowTitle.text = "추천 컨텐츠"
        rowTitle.textColor = .white
        rowTitle.font = .boldSystemFont(ofSize: 16)
    }
    
    static func collectionViewLayout() -> UICollectionViewLayout {
        
        let spacing: CGFloat = 10
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSize(width: 310, height: 380)
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
}
