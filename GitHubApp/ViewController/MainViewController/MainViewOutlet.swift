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


// MARK: - Navigation Bar
extension MainViewOutlet {
    
    func setupNavigationBar(_ navbar: UINavigationBar?) {
        guard let navbar = navbar else {
            return
        }
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
    }
}


extension MainViewOutlet {
    
    func startFetching() {
        tableView.tableFooterView = {
            let result = UIActivityIndicatorView(style: .white)
            result.frame.size.height = 60
            result.startAnimating()
            return result
        }()
    }
    
    func finishFetching() {
        tableView.tableFooterView = nil
    }
}

extension MainViewOutlet {
    
    func startLoading() {
        tableView.backgroundView = {
            let result = UIActivityIndicatorView(style: .white)
            result.startAnimating()
            return result
        }()
    }
    
    func finishLoading() {
        tableView.backgroundView = nil
    }
    
    func finishLoadingWithError() {
        
    }
}

private extension MainViewOutlet {
    
    func setupTableView() {
        let nib = UINib(nibName: "UserCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
    }
}



