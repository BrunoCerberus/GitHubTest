//
//  FilterCarouselCollectionViewCell.swift
//  GitHubTest
//
//  Created by Bruno on 12/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit

class FilterCarouselCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var carouselFilterCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        carouselFilterCollectionView.delegate = self
        carouselFilterCollectionView.dataSource = self
        carouselFilterCollectionView.register(FilterCollectionViewCell.self)
    }
}

extension FilterCarouselCollectionViewCell: UICollectionViewDelegate {
    
}

extension FilterCarouselCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return carouselFilterCollectionView.dequeueReusableCell(of: FilterCollectionViewCell.self,
                                                                for: indexPath) { cell in
                                                                cell.setup(filterName: "teste")
        }
    }
}

extension FilterCarouselCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = carouselFilterCollectionView.dequeueReusableCell(of: FilterCollectionViewCell.self,
                                                                    for: indexPath) as? FilterCollectionViewCell
        cell?.setup(filterName: "teste")
        cell?.setNeedsLayout()
        cell?.layoutIfNeeded()
        let size: CGSize = (cell?.contentView
            .systemLayoutSizeFitting(UIView.layoutFittingCompressedSize))!
        return CGSize(width: size.width, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
