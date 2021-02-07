//
//  FilterCollectionViewCell.swift
//  GitHubTest
//
//  Created by Bruno on 11/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit

protocol FilterCollectionViewDelegate: AnyObject {
    func removeFilterWith(name: String)
}

class FilterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var filterLabel: UILabel!
    
    weak var delegate: FilterCollectionViewDelegate?
    
    var index: Int!
    
    func setup(filterName: String) {
        filterLabel.text = filterName
    }
    
    @IBAction func closeFilter(_ sender: Any) {
        delegate?.removeFilterWith(name: filterLabel.text ?? "")
    }
}
