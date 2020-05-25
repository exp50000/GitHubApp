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
        completionHandler: @escaping (_ users: [AllUsersModel]?, _ hasMore: Bool, _ error: ErrorResponse?) -> Void) {
        
        requestData(UsersRouter.getAllUsers(since: since)) { response in
            var users: [AllUsersModel]?
            var hasMore: Bool = false
            var errorResponse: ErrorResponse?
            defer { completionHandler(users, hasMore, errorResponse) }
            
            switch response.result {
            case .success(let data):
                guard let response = [AllUsersModel].decode(from: data) else {
                    errorResponse = ErrorResponse.decode(from: data)
                    return
                }
                
                users = response
                hasMore = response.count >= 20
                
            case .failure(let error):
                errorResponse = ErrorResponse()
                errorResponse?.message = error.errorDescription
                
                print(error, terminator: "\n")
            }
        }
    }
}
