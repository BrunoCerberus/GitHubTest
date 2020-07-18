//
//  SecondaryInfoTableViewCell.swift
//  GitHubTest
//
//  Created by bruno on 09/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit

class SecondaryInfoTableViewCell: BaseTableViewCell {

    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var issuesLabel: UILabel!
    
    private func setup(repo: RepositoryElement) {
        forksLabel.text = "\(repo.forksCount ?? 0)"
        followersLabel.text = "\(repo.watchersCount ?? 0)"
        sizeLabel.text = "\(repo.size ?? 0)"
        issuesLabel.text = "\(repo.openIssuesCount ?? 0)"
    }
    
    override func bindData(_ data: Any?...) {
        guard let item = data.first as? RepoDetailCellType else { return }
        switch item {
        case .secondary(let repo):
            setup(repo: repo)
        default: break
        }
    }
}
