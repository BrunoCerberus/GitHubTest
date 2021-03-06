//
//  UIViewController+Utils.swift
//  GitHubTest
//
//  Created by bruno on 08/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit

extension UIViewController {
    
    @objc func dismissAnimated() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showBasicAlert(title: String, message: String, titleCancelButton: String = "OK") {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: titleCancelButton, style: .default, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showHUD(_ view: UIView? = nil) {
        HUD.show(view)
    }
    
    func hideHUD() {
        HUD.hide(afterDelay: 0)
    }
    
    func setupDismissLeftBarButtonItem(image: UIImage? = nil) {
        let closeBarButtonItem = UIBarButtonItem(
            image: image != nil ? image : #imageLiteral(resourceName: "BTN_CLOSE_WHITE").withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(self.dismissAnimated)
        )
        navigationItem.leftBarButtonItem = closeBarButtonItem
    }
    
    func setupLeftCloseBarButtonItem() {
        let img = UIImage(named: "BTN_CLOSE")
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: img,
                                                           landscapeImagePhone: img,
                                                           style: .plain,
                                                           target: self.navigationController,
                                                           action: #selector(self.dismissAnimated))
    }
    
    func navigationPopToRoot() {
        let img = UIImage(named: "BTN_BACK")
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: img,
                                                           landscapeImagePhone: img,
                                                           style: .plain,
                                                           target: self.navigationController,
                                                           action: #selector(navigationController?.popToRootViewController(animated:)))
    }
    
    func defaultBackButton() {
        let img = UIImage(named: "BTN_ARROW_BACK")
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: img,
                                                           landscapeImagePhone: img,
                                                           style: .plain,
                                                           target: self.navigationController,
                                                           action: #selector(navigationController?.popViewController(animated:)))
    }
    
    /// Executes a block of code on the main thread
    func onUIThread(code: @escaping () -> Void) {
        DispatchQueue.main.async {
            code()
        }
    }
    
}
