//
//  AlertManager.swift
//  GitHubTest
//
//  Created by bruno on 08/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation
import UIKit

struct AlertManager {
    let controller: UIViewController
    let title: String
    let msg: String
    let confirmButton: Bool
    let confirmAndCancelButton: Bool
    let isModal: Bool
    
    init(with controller: UIViewController, title: String, msg: String, confirmButton: Bool = true,
         confirmAndCancelButton: Bool = false, isModal: Bool = false) {
        self.controller = controller
        self.title = title
        self.msg = msg
        self.confirmButton = confirmButton
        self.confirmAndCancelButton = confirmAndCancelButton
        self.isModal = isModal
    }
    
    func showAlert() {
        let alerta = UIAlertController(title: "Atenção", message: self.msg, preferredStyle: UIAlertController.Style.alert)
        let confirmAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alerta.addAction(confirmAction)
        self.controller.present(alerta, animated: true, completion: nil)
    }
}
