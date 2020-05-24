//
//  UserCell.swift
//  GitHubApp
//
//  Created by Ric. on 2020/5/23.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var staffLabel: UILabel!
    
    private(set) var viewModel: UserCellViewModel?
    
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        self.containerView.backgroundColor = highlighted ? UIColor(r: 255, g: 248, b: 220) : .white
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            containerView.backgroundColor = UIColor(r: 255, g: 248, b: 220)
        } else {
            UIView.animate(withDuration: animated ? 0.5 : 0, delay: 0.1, animations: {
                self.containerView.backgroundColor = .white
            }, completion: nil)
        }
    }
}

extension UserCell {
    
    func configure(viewModel: UserCellViewModel) {
        
        
    }
}
