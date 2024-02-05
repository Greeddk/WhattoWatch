//
//  mediInfoView.swift
//  MovieTMDB
//
//  Created by Greed on 2/4/24.
//

import UIKit
import SnapKit

enum MediaType {
    case TV
    case Movie
}

class MediaCardView: BaseView {
    
    var isMovie: Bool = false

    let releasedateLabel = UILabel()
    let genreLabel = UILabel()
    let backView = UIView()
    let backShadowView = UIView()
    let posterImageView = UIImageView()
    let rateTextLabel = UILabel()
    let rateLabel = UILabel()
    let titleLabel = UILabel()
    let descLabel = UILabel()
    let lineView = UIView()
    let moreLabel = UILabel()
    let moreButton = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(type: MediaType) {
        self.init(frame: .zero)
        isMovie = type == .Movie ? true : false
    }
    
    override func configureHierarchy() {
        addSubviews([releasedateLabel, genreLabel, backView, backShadowView])
        backView.addSubviews([posterImageView, rateTextLabel, rateLabel, titleLabel, descLabel, lineView, moreLabel, moreButton])
    }
    
    override func layoutSubviews() {
        if isMovie {
            releasedateLabel.snp.makeConstraints { make in
                make.top.equalTo(self).offset(8)
                make.horizontalEdges.equalTo(self).inset(8)
                make.height.equalTo(20)
            }
            
            genreLabel.snp.makeConstraints { make in
                make.top.equalTo(releasedateLabel.snp.bottom)
                make.horizontalEdges.equalTo(self).inset(8)
                make.height.equalTo(20)
            }
            
            backView.snp.makeConstraints { make in
                make.top.equalTo(genreLabel.snp.bottom).offset(4)
                make.horizontalEdges.equalTo(self).inset(8)
                make.bottom.greaterThanOrEqualTo(self.safeAreaLayoutGuide).offset(-12)
            }
        } else {
            backView.snp.makeConstraints { make in
                make.top.equalTo(self).offset(4)
                make.horizontalEdges.equalTo(self).inset(8)
                make.bottom.greaterThanOrEqualTo(self).offset(-12)
            }
        }
  
        backShadowView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(60)
            make.bottom.equalTo(self).offset(28)
            make.horizontalEdges.equalTo(self).inset(10)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(backView)
            make.height.equalTo(240)
        }
        
        rateTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.leading).offset(10)
            make.bottom.equalTo(posterImageView.snp.bottom).offset(-10)
            make.width.equalTo(24)
            make.height.equalTo(20)
        }
        
        rateLabel.snp.makeConstraints { make in
            make.leading.equalTo(rateTextLabel.snp.trailing)
            make.top.equalTo(rateTextLabel.snp.top)
            make.width.equalTo(24)
            make.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(backView).inset(16)
            make.height.equalTo(24)
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.horizontalEdges.equalTo(backView).inset(16)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(backView).inset(16)
            make.height.equalTo(1)
        }
        
        moreButton.snp.makeConstraints { make in
            make.top.equalTo(lineView).offset(8)
            make.trailing.equalTo(backView).offset(-16)
            make.bottom.lessThanOrEqualTo(backView).offset(-16)
            make.size.equalTo(24)
        }
        
        moreLabel.snp.makeConstraints { make in
            make.leading.equalTo(backView).offset(16)
            make.centerY.equalTo(moreButton)
        }
    }
    
    override func configureView() {
        releasedateLabel.textColor = .white
        releasedateLabel.font = .boldSystemFont(ofSize: 12)
        releasedateLabel.text = "sadfasdfasd"
        
        genreLabel.font = .boldSystemFont(ofSize: 16)
        genreLabel.textColor = .white
        
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 10
        backView.backgroundColor = .systemGray6
        
        backShadowView.layer.shadowColor = UIColor.white.cgColor
        backShadowView.layer.shadowOpacity = 1
        backShadowView.layer.shadowRadius = 5
        backShadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        posterImageView.contentMode = .scaleAspectFill
        
        rateTextLabel.textAlignment = .center
        rateTextLabel.backgroundColor = .systemBlue
        rateTextLabel.textColor = .white
        rateTextLabel.text = "평점"
        rateTextLabel.font = .systemFont(ofSize: 10)
        
        rateLabel.backgroundColor = .white
        rateLabel.textAlignment = .center
        rateLabel.textColor = .systemBlue
        rateLabel.font = .systemFont(ofSize: 10)
        
        titleLabel.font = .systemFont(ofSize: 18)
        titleLabel.textColor = .black
        
        descLabel.textColor = .gray
        descLabel.numberOfLines = 1
        descLabel.font = .systemFont(ofSize: 14)
        
        lineView.backgroundColor = .systemGray
        
        moreLabel.text = "자세히 보기"
        moreLabel.textColor = .gray
        moreLabel.font = .boldSystemFont(ofSize: 13)
        
        moreButton.image = UIImage(systemName: "chevron.right")
        moreButton.tintColor = .gray
    }
    
    func configureCell(item: TVShow) {
        let url = TMDBAPI.imageURL(imageURL: item.backdrop_path ?? "").endpoint
        posterImageView.kf.setImage(with: url)
        
        rateLabel.text = String(format: "%.1f", item.vote_average)
        
        titleLabel.text = item.name
        descLabel.text = item.overview
    }
    
    func configureCell(item: Movie) {
        releasedateLabel.text = changeDateFormat(text: item.release_date)
        let genre = Genre.genreList.filter { $0.id == item.genre_ids[0] }
        genreLabel.text = "#\(genre[0].name)"
        
        let url = TMDBAPI.imageURL(imageURL: item.backdrop_path ?? "").endpoint
        posterImageView.kf.setImage(with: url)
        
        rateLabel.text = String(format: "%.1f", item.vote_average)
        
        titleLabel.text = item.title
        descLabel.text = item.overview
    }
    
    func changeDateFormat(text: String) -> String {
        
        let originFormatter = DateFormatter()
        originFormatter.dateFormat = "yyyy-MM-dd"
        guard let origin = originFormatter.date(from: text) else {
            return "정보 없음"
        }
        
        let targetFormatter = DateFormatter()
        targetFormatter.dateFormat = "yyyy/MM/dd"
        let result = targetFormatter.string(from: origin )
        
        return result
    }
    
}
