//
//  UITableView+Extension.swift
//  MovieTMDB
//
//  Created by Greed on 1/25/24.
//

import UIKit

protocol ReusableProtocol {
    static var identifier: String { get }
}

extension UIView: ReusableProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
}
