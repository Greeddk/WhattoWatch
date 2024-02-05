//
//  SearchTableViewCell.swift
//  MovieTMDB
//
//  Created by Greed on 2/5/24.
//

import UIKit
import SnapKit

class SearchTableViewCell: BaseTableViewCell {
    
    let rectangleImage = UIImageView()
    let title = UILabel()
    let goPageImage = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubviews([rectangleImage, title, goPageImage])
    }
    
    override func configureLayout() {
        rectangleImage.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView).inset(4)
            make.leading.equalTo(contentView).offset(10)
            make.width.equalTo(140)
            make.height.equalTo(80)
        }
        
        title.snp.makeConstraints { make in
            make.leading.equalTo(rectangleImage.snp.trailing).offset(10)
            make.trailing.equalTo(goPageImage.snp.leading)
            make.centerY.equalTo(contentView)
        }
        
        goPageImage.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(-10)
            make.width.equalTo(10)
        }
    }
    
    override func configureView() {
        rectangleImage.clipsToBounds = true
        rectangleImage.layer.cornerRadius = 4
        title.text = "text"
        title.textColor = .white
        title.font = .systemFont(ofSize: 14)
        goPageImage.image = UIImage(systemName: "chevron.right")
        goPageImage.tintColor = .lightGray
        goPageImage.contentMode = .scaleAspectFit
    }
    
}
