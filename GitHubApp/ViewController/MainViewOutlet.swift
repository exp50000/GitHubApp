//
//  MainViewOutlet.swift
//  GitHubApp
//
//  Created by Ric. on 2020/5/23.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit


class MainViewOutlet: NSObject {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            setupTableView()
        }
    }
}


extension MainViewOutlet {
    
    func setupNavigationBar(_ navbar: UINavigationBar?) {
        guard let navbar = navbar else {
            return
        }
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
    }
}


private extension MainViewOutlet {
    
    func setupTableView() {
        let nib = UINib(nibName: "UserCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
    }
}
