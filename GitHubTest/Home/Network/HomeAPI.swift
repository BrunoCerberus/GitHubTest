//
//  HomeAPI.swift
//  GitHubTest
//
//  Created by bruno on 09/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation

enum HomeAPI {
    case reposList
}

extension HomeAPI: Fetcher {
    var path: String {
        switch self {
        case .reposList:
            return "/now_playing"
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
