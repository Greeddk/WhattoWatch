//
//  UIView+Extension.swift
//  MovieTMDB
//
//  Created by Greed on 1/30/24.
//

import UIKit

extension UIView {

    func addSubviews(_ Views: [UIView]) {
        Views.forEach { addSubview($0)}
    }
}
