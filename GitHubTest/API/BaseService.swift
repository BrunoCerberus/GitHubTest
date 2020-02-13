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
    static let ApiKey = "2da5b254e987d3291cf8ae132e48ea54f3c43749"
    static var apiEndPoint: String {
        let value = "\(API.baseUrl)"
        return value
    }
}
