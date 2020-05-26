//
//  DetailViewModel.swift
//  GitHubApp
//
//  Created by Ric. on 2020/5/26.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation


class DetailViewModel: NSObject {
    
    @objc dynamic var apiStatus: APIStatus = .none
    
    private(set) var user: SingleUserModel?
    
    private(set) var name: String = ""
    
    private(set) var username: String = ""
    
    private(set) var location: String = ""
    
    private(set) var bio: String = ""
    
    private(set) var avatarURL: URL?
    
    private(set) var isStaff: Bool = false
    
    private(set) var blog: String = ""
    
    
    init(username: String) {
        self.username = username
    }
}

extension DetailViewModel {
    
    func getUser() {
        apiGetSingleUser()
    }
}

private extension DetailViewModel {
    
    func apiGetSingleUser() {
        apiStatus = .start
        
        UsersManager.GetSingleUser(username) { user, error in
            DispatchQueue.main.async {
                guard let user = user else {
                    self.apiStatus = .error
                    return
                }
                
                self.handleResultGetSingleUser(user)
            }
        }
    }
}

private extension DetailViewModel {
    
    func handleResultGetSingleUser(_ result: SingleUserModel) {
        user = result
        name = result.name ?? ""
        location = result.location ?? ""
        bio = result.bio ?? ""
        isStaff = result.site_admin == true
        blog = result.blog ?? ""
        
        if let url = result.avatar_url {
            avatarURL = URL(string: url)
        }
        
        apiStatus = .success
    }
}
