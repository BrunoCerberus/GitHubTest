//
//  RepoCellType.swift
//  GitHubTest
//
//  Created by Bruno on 7/18/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation

enum RepoDetailCellType {
    case main(repo: RepositoryElement)
    case secondary(repo: RepositoryElement)
    case readMe(repo: RepositoryElement)
    
    func cellType<T: BaseTableViewCell>() -> T.Type {
        switch self {
        case .main:
            return MainRepoInfoTableViewCell.self as? T.Type ?? T.self
        case .secondary:
            return SecondaryInfoTableViewCell.self as? T.Type ?? T.self
        case .readMe:
            return ReadMeTableViewCell.self as? T.Type ?? T.self
        }
    }
}
