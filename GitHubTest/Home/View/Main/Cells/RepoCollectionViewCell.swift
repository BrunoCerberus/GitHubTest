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
        upperView.backgroundColor = .imUpperView
        bottomView.backgroundColor = .imBottomView
        repoNameLabel.textColor = .white
        starsLabel.textColor = .white
        followersLabel.textColor = .white
        issuesLabel.textColor = .white
        lastUpdatedLabel.textColor = .white
            
    }
    
    func setup(repo: RepositoryElement, index: Int) {
        repoNameLabel.text = repo.name
        starsLabel.text = "\(repo.stargazersCount ?? 0)"
        followersLabel.text = "\(repo.watchersCount ?? 0)"
        issuesLabel.text = "\(repo.openIssuesCount ?? 0)"
        lastUpdatedLabel.text = "\(Date().days(sinceDate: repo.updatedAt ?? Date()) ?? 0) dias"
        if index % 2 != 0 && index != 0 {
            upperView.backgroundColor = .white
            bottomView.backgroundColor = .darkGray
            repoNameLabel.textColor = .black
            starsLabel.textColor = .black
        }
        guard let imageURL = repo.owner?.avatarURL else { return }
        repoImage.downloaded(from: imageURL)
    }
}
