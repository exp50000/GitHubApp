//
//  DetailViewOutlet.swift
//  GitHubApp
//
//  Created by Ric. on 2020/5/26.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit


class DetailViewOutlet: NSObject {
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            setupScrollView()
        }
    }
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var avatarContainerView: UIView!  {
        didSet {
            avatarHeight = avatarContainerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
            avatarHeight?.isActive = true
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var staffLabel: UILabel!
    
    @IBOutlet weak var locationColumnView: UIView!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var blogColumnView: UIView!
    
    @IBOutlet weak var blogTextView: UITextView! {
        didSet {
            blogTextView.textContainer.lineFragmentPadding = .zero
            blogTextView.textContainerInset.left = 0
        }
    }
    
    @IBOutlet weak var bioColumnView: UIView!
    
    @IBOutlet weak var bioTextView: UITextView! {
        didSet {
            bioTextView.textContainer.lineFragmentPadding = .zero
            bioTextView.textContainerInset.left = 0
        }
    }
    
    @IBOutlet weak var avatarTopConstraint: NSLayoutConstraint!
    
    private(set) var avatarHeight: NSLayoutConstraint?
    
    
    var lastContentOffset: CGPoint = .zero
}

extension DetailViewOutlet {
    
    func setupScrollView() {
        if #available(iOS 13.0, *) {
           scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        }
        
        scrollView.contentInset = UIEdgeInsets(top: UIScreen.main.bounds.width, left: 0, bottom: 0, right: 0)
        scrollView.contentInsetAdjustmentBehavior = .never
    }
    
    func transformAvatar(in scrollView: UIScrollView) {
        let y = UIScreen.main.bounds.width - (scrollView.contentOffset.y +  UIScreen.main.bounds.width)
        let height = max(0, y)
        
        avatarHeight?.constant = height
        avatarImageView.layoutIfNeeded()
    }
}

extension DetailViewOutlet {
    
    func setupNavigationBar(_ navbar: UINavigationBar?) {
        guard let navbar = navbar else {
            return
        }
        
        navbar.prefersLargeTitles = true
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
    }
}
