//
//  UITableView+Utils.swift
//  GitHubTest
//
//  Created by bruno on 08/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit

public extension UITableView {
    func register(_ cell: UITableViewCell.Type) {
        let nib = UINib(nibName: cell.identifier, bundle: nil)
        register(nib, forCellReuseIdentifier: cell.identifier)
    }
    
    func register(nibName: String, identifier: String? = nil) {
        let nib = UINib(nibName: nibName, bundle: nil)
        if let identifier = identifier {
            register(nib, forCellReuseIdentifier: identifier)
        } else {
            register(nib, forCellReuseIdentifier: nibName)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(of class: T.Type,
                                                 for indexPath: IndexPath,
                                                 configure: @escaping ((T) -> Void) = { _ in }) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath)
        if let typedCell = cell as? T {
            configure(typedCell)
        }
        return cell
    }
    
    func reloadData(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
            completion()
        })
    }
}
