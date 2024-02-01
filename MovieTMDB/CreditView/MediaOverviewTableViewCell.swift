//
//  MediaOverviewTableViewCell.swift
//  MovieTMDB
//
//  Created by Greed on 1/31/24.
//

import UIKit
import SnapKit

class MediaOverviewTableViewCell: BaseTableViewCell {

    let overviewContent = UITextView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubviews([overviewContent])
    }
    
    override func configureLayout() {
        overviewContent.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(16)
        }
    }
    
    override func configureView() {
        
    }

}
