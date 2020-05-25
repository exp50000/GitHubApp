//
//  MainViewController.swift
//  GitHubApp
//
//  Created by Ric. on 2020/5/23.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var viewOutlet: MainViewOutlet!
    
    var viewModel: MainViewModel = MainViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChangeListener()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewOutlet.setupNavigationBar(navigationController?.navigationBar)
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserCell
        let cellViewModel = viewModel.userViewModels[indexPath.row]
        cell.configure(viewModel: cellViewModel)
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController {
    
    func setupChangeListener() {
        viewModel.addChangeListener(\.apiStatus) { [weak self] _ in
            guard let self = self else { return }
            
            self.viewOutlet.tableView.reloadData()
        }
    }
}

