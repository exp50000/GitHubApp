//
//  MainViewModel.swift
//  GitHubApp
//
//  Created by Ric. on 2020/5/23.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit


class MainViewModel: NSObject {
    
    private(set) var userViewModels: [UserCellViewModel] = []
    
    private(set) var hasMore: Bool = false
    
    private(set) var insertIndexSet: [IndexPath] = []
    
    private(set) var errorMessage: String?
    
    @objc dynamic var apiAllUserStatus: APIStatus = .none
    @objc dynamic var apiMoreUserStatus: APIStatus = .none
    
    
    override init() {
        super.init()
        
    }
}


extension MainViewModel {
    
    func getAllUsers() {
        apiGetAllUsers()
    }
    
    func fetchMoreUsers() {
        guard let last = userViewModels.last?.id, hasMore else { return }
        apiGetMoreUsers(since: last)
    }
}

private extension MainViewModel {
    
    func apiGetAllUsers() {
        clearData()
        
        apiAllUserStatus = .start
        
        UsersManager.GetAllUsers { users, hasMore, error in
            DispatchQueue.main.async {
                guard let users = users else {
                    self.errorMessage = error?.message
                    self.apiAllUserStatus = .error
                    return
                }
                
                self.hasMore = hasMore
                self.handleResultGetAllUsers(users)
            }
        }
    }
    
    func apiGetMoreUsers(since: Int) {
        apiMoreUserStatus = .start
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UsersManager.GetAllUsers(since) { users, hasMore, error in
                DispatchQueue.main.async {
                    guard let users = users else {
                        self.errorMessage = error?.message
                        self.apiMoreUserStatus = .error
                        return
                    }
                    
                    self.hasMore = hasMore
                    self.handleResultGetMoreUsers(users)
                }
            }
        }
    }
    
    func clearData() {
        userViewModels.removeAll()
        insertIndexSet.removeAll()
        hasMore = false
        errorMessage = nil
    }
}

extension MainViewModel {
    
    func handleResultGetAllUsers(_ result: [AllUsersModel]) {
        guard !result.isEmpty else {
            return apiAllUserStatus = .empty
        }
        
        userViewModels = result.compactMap({ UserCellViewModel(user: $0) })
        apiAllUserStatus = .success
    }
    
    func handleResultGetMoreUsers(_ result: [AllUsersModel]) {
        guard !result.isEmpty else {
            return apiMoreUserStatus = .empty
        }
        
        let firstIndex = userViewModels.count
        userViewModels += result.compactMap({ UserCellViewModel(user: $0) })
        
        let lastIndex = userViewModels.count - 1
        insertIndexSet = Array(firstIndex...lastIndex).compactMap({ IndexPath(item: $0, section: 0) })
        
        apiMoreUserStatus = .success
        
        insertIndexSet.removeAll()
    }
}
