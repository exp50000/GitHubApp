//
//  UIImage+Extension.swift
//  GitHubApp
//
//  Created by Ric. on 2020/5/26.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit


extension UIImageView {
    
    static let tag = 999
    func startLoading() {
        var indicator = viewWithTag(UIImageView.tag) as? UIActivityIndicatorView
        
        if indicator == nil {
            indicator = UIActivityIndicatorView(style: .white)
        }
        
        indicator?.translatesAutoresizingMaskIntoConstraints = false
        indicator?.startAnimating()
        indicator?.hidesWhenStopped = true
        indicator?.tag = UIImageView.tag
        addSubview(indicator!)
        
        indicator?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        indicator?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func stopLoading() {
        let loading = viewWithTag(UIImageView.tag) as? UIActivityIndicatorView
        loading?.stopAnimating()
        loading?.removeFromSuperview()
    }
}
