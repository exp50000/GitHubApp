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
        viewModel.getAllUsers()
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.userViewModels.count - 1 &&
           viewModel.hasMore {
            viewModel.fetchMoreUsers()
        }
    }
}

extension MainViewController {
    
    func setupChangeListener() {
        viewModel.addChangeListener(\.apiAllUserStatus) { [weak self] _ in
            guard let self = self else { return }
            
            self.viewOutlet.tableView.reloadData()
            
            switch self.viewModel.apiAllUserStatus {
            case .start:
                self.viewOutlet.startLoading()
            case .error:
                self.showErrorAlert(with: self.viewModel.errorMessage)
                self.viewOutlet.finishLoading()
            default:
                self.viewOutlet.finishLoading()
            }
        }
        
        viewModel.addChangeListener(\.apiMoreUserStatus) { [weak self] _ in
            guard let self = self else { return }
            
            switch self.viewModel.apiMoreUserStatus {
            case .start:
                self.viewOutlet.startFetching()
            case .success:
                self.view.isUserInteractionEnabled = false
                self.viewOutlet.tableView.beginUpdates()
                self.viewOutlet.tableView.insertRows(at: self.viewModel.insertIndexSet, with: .fade)
                self.viewOutlet.tableView.endUpdates()
                self.view.isUserInteractionEnabled = true
            case .error:
                self.showErrorAlert(with: self.viewModel.errorMessage)
                self.viewOutlet.finishFetching()
            default:
                self.viewOutlet.finishFetching()
            }
        }
    }
}

extension MainViewController {
    
    func showErrorAlert(with message: String?) {
        let alert = UIAlertController(title: "There's Some Trouble!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

