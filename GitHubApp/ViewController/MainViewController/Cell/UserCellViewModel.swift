//
//  UserCellViewModel.swift
//  GitHubApp
//
//  Created by Ric. on 2020/5/23.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation



class UserCellViewModel {
    
    private(set) var id: Int
    
    private(set) var name: String = ""
    
    private(set) var photoURL: URL?
    
    private(set) var isSiteAdmin: Bool = false
    
    
    init(user: AllUsersModel) {
        id = user.id ?? -1
        name = user.login ?? ""
        photoURL = URL(string: user.avatar_url ?? "")
        isSiteAdmin = user.site_admin == true
    }
}
