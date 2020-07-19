//
//  HomeViewElements.swift
//  GitHubTestUITesting
//
//  Created by Bruno on 7/19/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation

enum HomeViewElements {
    case home
    
    case homeTitle
}

extension HomeViewElements: IdentifierViewProtocol {
    var identifier: String {
        switch self {
        case .home:
            return "homeCollection"
        default:
            return ""
        }
    }
}

extension HomeViewElements: LabelViewProtocol {
    var label: String {
        switch self {
        case .homeTitle:
            return "GitHub"
        default:
            return ""
        }
    }
}

