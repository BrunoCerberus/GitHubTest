//
//  FilterCollectionViewCell.swift
//  GitHubTest
//
//  Created by Bruno on 11/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit

protocol FilterCollectionViewDelegate: AnyObject {
    func removeFilterAt(index: Int)
}

class FilterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var filterLabel: UILabel!
    
    weak var delegate: FilterCollectionViewDelegate?
    
    var index: Int!
    
    func setup(filterName: String, on index: Int = 0) {
        filterLabel.text = filterName
        self.index = index
    }

    @IBAction func closeFilter(_ sender: Any) {
        delegate?.removeFilterAt(index: index)
    }
}
