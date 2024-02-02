//
//  BaseTableViewCell.swift
//  MovieTMDB
//
//  Created by Greed on 1/31/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell, CodeBase {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .backColor
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        
    }
    
    func configureView() {
        
    }
    
    func configureLayout() {
        
    }

}
