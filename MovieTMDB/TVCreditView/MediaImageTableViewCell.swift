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
    let originName = UILabel()
    let rate = UILabel()
    let airDate = UILabel()
    let genre = UILabel()
    let numberOfSeasons = UILabel()
    let numberOfEpisodes = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubviews([backImageView, poster, mediaName, originName, rate, airDate, genre, numberOfSeasons, numberOfEpisodes])
    }
    
    override func configureView() {
        backImageView.image = UIImage(systemName: "pencil")
        backImageView.alpha = 0.3
        poster.image = UIImage(systemName: "person")
        poster.contentMode = .scaleAspectFill
        poster.clipsToBounds = true
        poster.layer.cornerRadius = 10
        mediaName.font = .boldSystemFont(ofSize: 20)
        mediaName.textColor = .white
        mediaName.numberOfLines = 2
        originName.font = .systemFont(ofSize: 12)
        originName.textColor = .lightGray
        originName.text = "wonka"
        rate.font = .systemFont(ofSize: 15)
        rate.textColor = .white
        rate.text = "| ★ 8.9"
        airDate.font = .systemFont(ofSize: 13)
        airDate.textColor = .white
        airDate.text = "8888-88-88 ~ 8888-88-88"
        genre.font = .systemFont(ofSize: 15)
        genre.textColor = .white
        genre.text = "액션, 드라마"
        numberOfSeasons.font = .systemFont(ofSize: 15)
        numberOfSeasons.textColor = .white
        numberOfSeasons.text = "2개의 시즌"
        numberOfEpisodes.font = .systemFont(ofSize: 15)
        numberOfEpisodes.textColor = .white
        numberOfEpisodes.text = "9의 에피소드"
        
    }
    
    override func configureLayout() {
        backImageView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(contentView)
            make.width.equalTo(contentView)
            make.height.equalTo(240)
        }
        
        poster.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.width.equalTo(130)
            make.height.equalTo(200)
        }
        
        airDate.snp.makeConstraints { make in
            make.bottom.equalTo(poster.snp.bottom).offset(-4)
            make.leading.equalTo(poster.snp.trailing).offset(20)
        }
        
        numberOfEpisodes.snp.makeConstraints { make in
            make.bottom.equalTo(airDate.snp.top).offset(-4)
            make.leading.equalTo(airDate)
        }
        
        numberOfSeasons.snp.makeConstraints { make in
            make.bottom.equalTo(numberOfEpisodes.snp.top).offset(-4)
            make.leading.equalTo(airDate)
        }
        
        rate.snp.makeConstraints { make in
            make.bottom.equalTo(numberOfSeasons.snp.top).offset(-4)
            make.leading.equalTo(airDate)
        }
        
        genre.snp.makeConstraints { make in
            make.bottom.equalTo(rate.snp.top).offset(-4)
            make.trailing.equalTo(contentView)
            make.leading.equalTo(airDate)
        }
        
        originName.snp.makeConstraints { make in
            make.bottom.equalTo(genre.snp.top).offset(-12)
            make.leading.equalTo(airDate)
        }
        
        mediaName.snp.makeConstraints { make in
            make.bottom.equalTo(originName.snp.top).offset(-2)
            make.leading.equalTo(airDate)
            make.trailing.equalTo(contentView)
        }
        
    }

}
