//
//  BaseView.swift
//  MovieTMDB
//
//  Created by Greed on 2/4/24.
//
import UIKit

class BaseView: UIView, CodeBase {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backColor
        configureHierarchy()
        configureView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureView() { }
    
}
