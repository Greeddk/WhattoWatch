//
//  MediaImageTableViewCell.swift
//  MovieTMDB
//
//  Created by Greed on 1/31/24.
//

import UIKit
import SnapKit

class MediaImageTableViewCell: BaseTableViewCell {
    
    let backImageView = UIImageView()
    let poster = UIImageView()
    let mediaName = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubviews([backImageView, poster, mediaName])
    }
    
    override func configureView() {
        mediaName.font = .boldSystemFont(ofSize: 20)
        mediaName.textColor = .white
    }
    
    override func configureLayout() {
        backImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        mediaName.snp.makeConstraints { make in
            make.top.leading.equalTo(backImageView.snp.top).offset(20)
        }
        
        poster.snp.makeConstraints { make in
            make.top.equalTo(mediaName.snp.bottom).offset(8)
            make.leading.equalTo(mediaName)
        }
    }

}
