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
        backImageView.image = UIImage(systemName: "pencil")
        backImageView.alpha = 0.4
        poster.image = UIImage(systemName: "person")
        poster.contentMode = .scaleAspectFill
        mediaName.font = .boldSystemFont(ofSize: 20)
        mediaName.textColor = .white
    }
    
    override func configureLayout() {
        backImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        mediaName.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(12)
        }
        
        poster.snp.makeConstraints { make in
            make.top.equalTo(mediaName.snp.bottom).offset(8)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(110)
            make.height.equalTo(180)
        }
    }

}
