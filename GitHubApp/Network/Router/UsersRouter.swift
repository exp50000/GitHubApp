//
//  UsersRouter.swift
//  GitHubApp
//
//  Created by Ric. on 2020/5/25.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation
import Alamofire


enum UsersRouter: URLRequestConvertible, RequestRoutable {
    
    case getAllUsers(since: Int?)
    case getSingleUser(username: String)
    
    
    var controllerName: String {
        return "users"
    }
    
    var request: String {
        switch self {
        case .getAllUsers:
            return ""
        case .getSingleUser(let username):
            return "/\(username)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getAllUsers(let since):
            var params: [String : Any] = ["per_page": 20]
            
            if let since = since {
                params["since"] = since
            }
            
            return params
        case .getSingleUser:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        return try APIRouterHelper.URLRequest(requestRouter: self)
    }
}
