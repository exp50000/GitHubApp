//
//  UsersManager.swift
//  GitHubApp
//
//  Created by Ric. on 2020/5/25.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation
import Alamofire

class UsersManager {
    
    class func GetAllUsers(
        _ since: Int? = nil,
        completionHandler: @escaping (_ users: [AllUsersModel]?, _ hasMore: Bool) -> Void) {
        
        requestData(UsersRouter.getAllUsers(since: since)) { response in
            var users: [AllUsersModel]?
            var hasMore: Bool = false
            defer { completionHandler(users, hasMore) }
            
            switch response.result {
            case .success(let data):
                guard let response = [AllUsersModel].decode(from: data) else {
                    return
                }
                
                users = response
                hasMore = response.count >= 20
                
            case .failure(let error):
                print(error, terminator: "\n")
            }
        }
    }
}
