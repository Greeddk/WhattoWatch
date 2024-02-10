//
//  SettingDetailViewController.swift
//  MovieTMDB
//
//  Created by Greed on 2/10/24.
//

import UIKit
import SnapKit

class SettingDetailViewController: BaseViewController {
    
    let mainView = SettingDetailView()
    var userTextFieldSpace: ((String) -> Void)?
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    override func configureView() {
        let commitButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(commitButtonClicked))
        navigationItem.rightBarButtonItem = commitButton
    }
    
    @objc
    private func commitButtonClicked() {
        userTextFieldSpace?(mainView.userTextField.text!)
        navigationController?.popViewController(animated: true)
    }
    
}
