//
//  UICollectionView+Utils.swift
//  GitHubTest
//
//  Created by bruno on 08/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func register(_ cell: UICollectionViewCell.Type) {
        let nib = UINib(nibName: cell.identifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: cell.identifier)
    }
    
    func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }
    
    func register(cellTypes: [UICollectionViewCell.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle)}
    }
    
    func registerHeader(_ reusableView: UICollectionReusableView.Type) {
        let nib = UINib(nibName: reusableView.identifier, bundle: nil)
        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: reusableView.identifier)
    }
    
    func registerFooter(_ reusableView: UICollectionReusableView.Type) {
        let nib = UINib(nibName: reusableView.identifier, bundle: nil)
        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                 withReuseIdentifier: reusableView.identifier)
    }
    
    func dequeueBaseCell<T: BaseCollectionViewCell>(with type: T.Type, for row: Int) -> T {
        let indexPath = IndexPath(row: row, section: 0)
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as? T else {
            return T()
        }
        
        return cell
    }
    
    func dequeueBaseCell<T: BaseCollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as? T else {
            return T()
        }
        return cell
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as? T else {
            return T()
        }
        return cell
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(of class: T.Type,
                                                      for indexPath: IndexPath,
                                                      configure: @escaping ((T) -> Void) = { _ in }) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath)
        if let typedCell = cell as? T {
            configure(typedCell)
        }
        return cell
    }
    
    func dequeueReusableHeader<T: UICollectionReusableView>(of class: T.Type,
                                                            for indexPath: IndexPath,
                                                            configure: @escaping (T) -> Void = { _ in }) -> UICollectionReusableView {
        let header = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: T.identifier,
            for: indexPath
        )
        if let headerCell = header as? T {
            configure(headerCell)
        }
        return header
    }
    
    func dequeueReusableFooter<T: UICollectionReusableView>(of class: T.Type,
                                                            for indexPath: IndexPath,
                                                            configure: @escaping (T) -> Void = { _ in }) -> UICollectionReusableView {
        let footer = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: T.identifier,
            for: indexPath
        )
        if let footerCell = footer as? T {
            configure(footerCell)
        }
        return footer
    }
}
