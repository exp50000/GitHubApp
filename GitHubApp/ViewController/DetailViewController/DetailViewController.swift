//
//  DetailViewController.swift
//  GitHubApp
//
//  Created by Ric. on 2020/5/26.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: BaseViewController {

    @IBOutlet weak var viewOutlet: DetailViewOutlet!
    
    var viewModel: DetailViewModel!
    
    var isStatusBarHidden: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChangeListener()
        viewModel.getUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewOutlet.setupNavigationBar(navigationController?.navigationBar)
        
        isStatusBarHidden = true
        UIView.animate(withDuration: 0.5) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
}

extension DetailViewController {
    
    @IBAction func closeButtonDidSelect(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension DetailViewController {
    
    func setupUI() {
        viewOutlet.nameLabel.text = viewModel.name
        viewOutlet.avatarImageView.sd_setImage(with: viewModel.avatarURL, completed: nil)
        viewOutlet.usernameLabel.text = viewModel.username
        viewOutlet.staffLabel.isHidden = !viewModel.isStaff
        viewOutlet.locationLabel.text = viewModel.location
        viewOutlet.locationColumnView.isHidden = viewModel.location.isEmpty
        viewOutlet.blogTextView.text = viewModel.blog
        viewOutlet.blogColumnView.isHidden = viewModel.blog.isEmpty
        viewOutlet.bioTextView.text = viewModel.bio
        viewOutlet.bioColumnView.isHidden = viewModel.bio.isEmpty
    }
}

extension DetailViewController {
    
    func setupChangeListener() {
        viewModel.addChangeListener(\.apiStatus) { [weak self] _ in
            guard let self = self else { return }
            
            switch self.viewModel.apiStatus {
            case .start:
                self.viewOutlet.avatarImageView.startLoading()
            case .success:
                self.viewOutlet.avatarImageView.stopLoading()
                self.setupUI()
            default: return
            }
        }
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewOutlet.transformAvatar(in: scrollView)
    }
}
