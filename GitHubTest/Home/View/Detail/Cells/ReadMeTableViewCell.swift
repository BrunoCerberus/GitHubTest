//
//  ReadMeTableViewCell.swift
//  GitHubTest
//
//  Created by bruno on 09/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit

class ReadMeTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var readMeLabel: UILabel!
    
    func setup(repo: RepositoryElement) {
        
    }
    
    override func bindData(_ data: Any?...) {
        guard let item = data.first as? RepoDetailCellType else { return }
        switch item {
        case .readMe(let repo):
            setup(repo: repo)
        default: break
        }
    }
}
