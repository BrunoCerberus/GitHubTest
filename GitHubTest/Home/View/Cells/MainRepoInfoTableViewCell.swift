//
//  MainRepoInfoTableViewCell.swift
//  GitHubTest
//
//  Created by bruno on 09/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit

class MainRepoInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var repoImage: UIImageView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    
    func setup(repo: RepositoryElement) {
        repoNameLabel.text = repo.name
        starsLabel.text = "\(repo.stargazersCount ?? 0)"
    }
}
