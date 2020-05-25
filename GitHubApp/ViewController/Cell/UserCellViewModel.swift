//
//  UserCellViewModel.swift
//  GitHubApp
//
//  Created by Ric. on 2020/5/23.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation



class UserCellViewModel {
    
    var name: String = ""
    
    var photoURL: URL?
    
    var isSiteAdmin: Bool = false
    
    
    init(user: AllUsersModel) {
        name = user.login ?? ""
        photoURL = URL(string: user.avatar_url ?? "")
        isSiteAdmin = user.site_admin == true
    }
}
