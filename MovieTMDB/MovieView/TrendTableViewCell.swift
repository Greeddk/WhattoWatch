//
//  TrendTableViewCell.swift
//  MovieTMDB
//
//  Created by Greed on 1/25/24.
//

import UIKit
import Kingfisher

class TrendTableViewCell: UITableViewCell {
    
    @IBOutlet var releasedateLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    
    @IBOutlet var backView: UIView!
    @IBOutlet var backShadowView: UIView!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var rateTextLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var lineView: UIView!
    @IBOutlet var moreLabel: UILabel!
    @IBOutlet var moreButton: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        DispatchQueue.main.async {
            self.setUI()
        }
    }

}

extension TrendTableViewCell {
    
    private func setUI() {
        
        releasedateLabel.textColor = .gray
        releasedateLabel.font = .boldSystemFont(ofSize: 12)
        
        genreLabel.font = .boldSystemFont(ofSize: 16)
        
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 10
        
        backShadowView.layer.shadowColor = UIColor.black.cgColor
        backShadowView.layer.shadowOpacity = 1
        backShadowView.layer.shadowRadius = 5
        backShadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backShadowView.layer.shadowPath = nil
        
        posterImageView.contentMode = .scaleAspectFill
        
        rateTextLabel.textAlignment = .center
        rateTextLabel.backgroundColor = .systemPurple
        rateTextLabel.textColor = .white
        rateTextLabel.font = .systemFont(ofSize: 10)
        
        rateLabel.backgroundColor = .white
        rateLabel.textAlignment = .center
        rateLabel.textColor = .systemPurple
        rateLabel.font = .systemFont(ofSize: 10)
        
        titleLabel.font = .systemFont(ofSize: 18)
        
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
    
    func configureCell(item: Movie) {
        
        releasedateLabel.text = changeDateFormat(text: item.release_date)
        let genre = Genre.genreList.filter { $0.id == item.genre_ids[0] }
        genreLabel.text = "#\(genre[0].name)"
        
        let url = URL(string: "https://image.tmdb.org/t/p/original/\(item.backdrop_path)")
        posterImageView.kf.setImage(with: url)
        
        rateLabel.text = String(format: "%.1f", item.vote_average)
        
        titleLabel.text = item.title
        descLabel.text = item.overview
    }
    
    func changeDateFormat(text: String) -> String {
        
        let originFormatter = DateFormatter()
        originFormatter.dateFormat = "yyyy-MM-dd"
        let origin = originFormatter.date(from: text)!
        
        let targetFormatter = DateFormatter()
        targetFormatter.dateFormat = "yyyy/dd/MM"
        let result = targetFormatter.string(from: origin)
        
        return result
    }
    
}
