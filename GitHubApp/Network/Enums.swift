//
//  Enums.swift
//  GitHubApp
//
//  Created by Ric. on 2020/5/25.
//  Copyright © 2020 Ric. All rights reserved.
//

import Foundation


/// Call api 時的狀態.
@objc enum APIStatus: Int {
    case none
    case start
    case success
    case error
    case empty
}
