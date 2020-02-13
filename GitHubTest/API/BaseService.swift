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
    static let ApiKey = "2f60cdf4a1b5715a8f0d1dec0356f2ae3ac3a3d3"
    static var apiEndPoint: String {
        let value = "\(API.baseUrl)"
        return value
    }
}
