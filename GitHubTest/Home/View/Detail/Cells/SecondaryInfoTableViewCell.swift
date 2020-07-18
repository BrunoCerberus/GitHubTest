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
    
    func setup(repo: RepositoryElement) {
        forksLabel.text = "\(repo.forksCount ?? 0)"
        followersLabel.text = "\(repo.watchersCount ?? 0)"
        sizeLabel.text = "\(repo.size ?? 0)"
        issuesLabel.text = "\(repo.openIssuesCount ?? 0)"
    }
}
