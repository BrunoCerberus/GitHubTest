//
//  RepoCollectionViewCell.swift
//  GitHubTest
//
//  Created by bruno on 09/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit

class RepoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var repoImage: UIImageView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var issuesLabel: UILabel!
    @IBOutlet weak var lastUpdatedLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        repoNameLabel.text = ""
        starsLabel.text = ""
        followersLabel.text = ""
        issuesLabel.text = ""
        lastUpdatedLabel.text = ""
    }
    
    func setup(repo: RepositoryElement) {
        repoNameLabel.text = repo.name
        starsLabel.text = "\(repo.stargazersCount ?? 0)"
        followersLabel.text = "\(repo.watchersCount ?? 0)"
        issuesLabel.text = "\(repo.openIssuesCount ?? 0)"
        lastUpdatedLabel.text = "\(Date().days(sinceDate: repo.updatedAt ?? Date()) ?? 0)"
    }
}
