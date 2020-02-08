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
    
    static var apiEndPoint: String {
        let value = "\(API.baseUrl)"
        return value
    }
}
