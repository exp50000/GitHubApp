//
//  MainViewModel.swift
//  GitHubApp
//
//  Created by Ric. on 2020/5/23.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation


class MainViewModel: NSObject {
    
    @objc dynamic var apiStatus: APIStatus = .none
    
    private(set) var userViewModels: [UserCellViewModel] = []
    
    private(set) var hasMore: Bool = false
    
    
    override init() {
        super.init()
        
        getAllUsers()
    }
}

extension MainViewModel {
    
    func getAllUsers() {
        UsersManager.GetAllUsers { users, hasMore in
            DispatchQueue.main.async {
                guard let users = users else {
                    return self.apiStatus = .error
                }
                
                self.hasMore = hasMore
                self.handleResultGetAllUsers(users)
            }
        }
    }
}

extension MainViewModel {
    
    func handleResultGetAllUsers(_ result: [AllUsersModel]) {
        guard !result.isEmpty else {
            return apiStatus = .empty
        }
        
        userViewModels = result.compactMap({ UserCellViewModel(user: $0) })
        apiStatus = .success
    }
}
