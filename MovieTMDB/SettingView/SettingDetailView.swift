//
//  SettingDetailView.swift
//  MovieTMDB
//
//  Created by Greed on 2/10/24.
//

import UIKit
import SnapKit

class SettingDetailView: BaseView {
    
    let settingTitle = UILabel()
    let userTextField = UITextField()
    
    override func configureHierarchy() {
        addSubviews([settingTitle, userTextField])
    }
    
    override func configureLayout() {
        settingTitle.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(10)
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
        }
        
        userTextField.snp.makeConstraints { make in
            make.top.equalTo(settingTitle.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
        }
    }
    
    override func configureView() {
        settingTitle.textColor = .systemGray
        settingTitle.font = .systemFont(ofSize: 13)
    }
    
}
