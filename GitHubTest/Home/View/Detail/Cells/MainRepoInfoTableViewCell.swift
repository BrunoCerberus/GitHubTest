//
//  MainRepoInfoTableViewCell.swift
//  GitHubTest
//
//  Created by bruno on 09/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit

class MainRepoInfoTableViewCell: BaseTableViewCell {

    @IBOutlet weak var repoImage: UIImageView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    
    private func setup(repo: RepositoryElement) {
        repoNameLabel.text = repo.name
        starsLabel.text = "\(repo.stargazersCount ?? 0)"
        guard let imageURL = repo.owner?.avatarURL else { return }
        repoImage.downloaded(from: imageURL)
    }
    
    override func bindData(_ data: Any?...) {
        guard let item = data.first as? RepoDetailCellType else { return }
        switch item {
        case .main(let repo):
            setup(repo: repo)
        default: break
        }
    }
}
