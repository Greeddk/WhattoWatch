//
//  SettingTableViewCell.swift
//  MovieTMDB
//
//  Created by Greed on 2/10/24.
//

import UIKit
import SnapKit

class SettingTableViewCell: BaseTableViewCell {

    let title = UILabel()
    let userInfoLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        addSubviews([title, userInfoLabel])
    }
    
    override func configureLayout() {
        title.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(10)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        userInfoLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(120)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        title.textColor = .white
        
        userInfoLabel.textColor = .systemGray
    }

}
