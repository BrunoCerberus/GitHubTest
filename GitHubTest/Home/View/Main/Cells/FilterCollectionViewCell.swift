//
//  FilterCollectionViewCell.swift
//  GitHubTest
//
//  Created by Bruno on 11/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var filterLabel: UILabel!
    
    func setup(filterName: String) {
        filterLabel.text = filterName
    }

    @IBAction func closeFilter(_ sender: Any) {
        
    }
}
