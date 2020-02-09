//
//  HomeAPI.swift
//  GitHubTest
//
//  Created by bruno on 09/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation

enum HomeAPI {
    case reposList(page: Int)
}

extension HomeAPI: Fetcher {
    var path: String {
        switch self {
        case .reposList(let page):
            return "/orgs/octokit/repos?page=\(page)&per_page=10"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .reposList:
            return .GET
        }
    }
    
    var task: IMCodable? {
        switch self {
        case .reposList:
            return nil
        }
    }
}
