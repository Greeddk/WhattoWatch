//
//  SettingViewController.swift
//  MovieTMDB
//
//  Created by Greed on 2/9/24.
//

import UIKit

class SettingViewController: BaseViewController {
    
    let mainView = SettingView()
    
    let textFields = ["이름", "사용자 이름", "성별", "소개", "링크"]
    var placeHolders = ["이름을 입력해주세요", "사용자의 이름을 입력해주세요", "성별을 입력해주세요", "자신의 소개를 적어주세요", "링크를 입력해주세요"]
    var userInfos = ["", "", "", "", ""]
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.tableView.reloadData()
    }
    
    override func configureView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        mainView.tableView.rowHeight = 50
    }
    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
        cell.title.text = textFields[indexPath.row]
        if userInfos[indexPath.row] != "" {
            cell.userInfoLabel.text = userInfos[indexPath.row]
            cell.userInfoLabel.textColor = .white
        } else {
            cell.userInfoLabel.text = placeHolders[indexPath.row]
            cell.userInfoLabel.textColor = .systemGray
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SettingDetailViewController()
        vc.navigationItem.title = textFields[indexPath.row]
        vc.mainView.settingTitle.text = textFields[indexPath.row]
        
        vc.userTextFieldSpace = { value in
            self.userInfos[indexPath.row] = value
        }
        
        if userInfos[indexPath.row] != "" {
            vc.mainView.userTextField.text = userInfos[indexPath.row]
        } else {
            vc.mainView.userTextField.placeholder = placeHolders[indexPath.row]
        }
        
        navigationController?.pushViewController(vc, animated: true)
        
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
}
