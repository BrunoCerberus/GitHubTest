//
//  BaseService.swift
//  GitHubTest
//
//  Created by bruno on 08/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation

enum API {
    static let baseUrl = "https://api.github.com"
    static let ApiKey = "4c34e8707be77b7c428bfaec57d8bf08570a4184"
    static var apiEndPoint: String {
        let value = "\(API.baseUrl)"
        return value
    }
}
