//
//  UITableView+Utils.swift
//  GitHubTest
//
//  Created by bruno on 08/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit

public extension UITableView {
    
    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        self.register(nib, forCellReuseIdentifier: className)
    }
    
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
    
    func register(cellTypes: [UITableViewCell.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }
    
    func dequeueBaseCell<T: BaseTableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: type.className,
                                             for: indexPath) as? T
            else { return T() }
        
        return cell
    }
    
    func registerHeaderFooter(_ reusableView: UITableViewHeaderFooterView.Type) {
        let nib = UINib(nibName: reusableView.identifier, bundle: nil)

        register(nib, forHeaderFooterViewReuseIdentifier: reusableView.identifier)
    }
    
    func registerHeaderFooter(nibName: String, identifier: String? = nil) {
        let nib = UINib(nibName: nibName, bundle: nil)
        
        if let identifier = identifier {
            register(nib, forHeaderFooterViewReuseIdentifier: identifier)
        } else {
            register(nib, forHeaderFooterViewReuseIdentifier: nibName)
        }
    }
    
    func setHeightTableHeaderView(height: CGFloat) {
        DispatchQueue.main.async { [weak self] in
            guard let headerView = self?.tableHeaderView else { return }
            var newFrame = headerView.frame
            newFrame.size.height = height
            
            UIView.animate(withDuration: 0.1) {
                self?.beginUpdates()
                headerView.frame = newFrame
                self?.endUpdates()
            }
        }
    }
    
    func setHeightTableFooterView(height: CGFloat) {
        DispatchQueue.main.async { [weak self] in
            guard let footerView = self?.tableFooterView else { return }
            var newFrame = footerView.frame
            newFrame.size.height = height
            
            UIView.animate(withDuration: 0.1) {
                self?.beginUpdates()
                footerView.frame = newFrame
                self?.endUpdates()
            }
        }
    }
    
//    func dequeueBaseCell<T: BaseTableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
//        guard let cell = dequeueReusableCell(withIdentifier: type.className,
//                                             for: indexPath) as? T
//            else { return T() }
//        
//        return cell
//    }
    
    func dequeueReusableCell<T: UITableViewCell>(of class: T.Type,
                                                 for indexPath: IndexPath,
                                                 configure: @escaping ((T) -> Void) = { _ in }) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath)
        if let typedCell = cell as? T {
            configure(typedCell)
        }
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(of class: T.Type) -> T? {
        let view = dequeueReusableHeaderFooterView(withIdentifier: T.identifier)
        if let typedView = view as? T {
            return typedView
        }
        return nil
    }
    
    func genericDequeueReusableCell(of identifier: String,
                                    for indexPath: IndexPath,
                                    configure: @escaping ((UITableViewCell) -> Void) = { _ in }) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        configure(cell)
        return cell
    }
    
    func reloadData(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
            completion()
        })
    }
    
    func updateRow(at indexPath: IndexPath, withAnimation: UITableView.RowAnimation) {
        self.beginUpdates()
        self.reloadRows(at: [indexPath], with: withAnimation)
        self.endUpdates()
    }
    
    func removeRow(at indexPath: IndexPath, withAnimation: UITableView.RowAnimation) {
        self.beginUpdates()
        self.deleteRows(at: [indexPath], with: withAnimation)
        self.endUpdates()
    }
}
