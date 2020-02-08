//
//  AlertManager.swift
//  GitHubTest
//
//  Created by bruno on 08/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit

class AlertManager {
    private var alertController: UIAlertController?
    private var alertType: AlertType
    private var title: String?
    private var message: String?
    private var buttonTitle: String?
    private var blockText: String?
    
    /// Alert types
    ///
    /// - toast: For toast alert selection
    /// - modal: For modal alert selection
    enum AlertType {
        case normal
        case confirm
        case customConfirm(dismissActionTitle: String, confirmActionTitle: String)
        case block
        case custom(_ buttonTitle: String)
    }
    
    /// Initializer for toast
    ///
    /// - Parameters:
    ///   - toastType: What kind of toast based on ToastAlertType
    ///   - title: The alert title
    ///   - message: The message
    init(with alertType: AlertType,
         title: String,
         message: String,
         backgroundColor: UIColor? = nil,
         foregroundColor: UIColor = .white,
         showIconImage: Bool = true,
         presentationStyle: PresentationType? = nil) {
        self.alertType              = alertType
        self.title             = title
        self.message           = message
    }
    
    /// An optional button tap handler. The `button` is automatically
    /// configured to call this tap handler on `.TouchUpInside`.
    open var buttonTapHandler: ((_ button: UIButton) -> Void)?
    
    /// Initializer for toast
    ///
    /// - Parameters:
    ///   - toastType: What kind of toast based on ToastAlertType
    ///   - title: The alert title
    ///   - message: The message
    ///   - buttonTitle: The message
    ///   - buttonTapHandler: Action Button Tap Handler
    init(with alertType: AlertType,
         title: String, message: String,
         buttonTitle: String,
         presentationStyle: PresentationType? = nil,
         buttonTapHandler: ((_ button: UIButton) -> Void)?) {
        self.alertType              = alertType
        self.title             = title
        self.message           = message
        self.buttonTitle       = buttonTitle
        self.buttonTapHandler = buttonTapHandler
    }

    private func showAlertController() {
        guard let alertController = alertController, let window = UIApplication.shared.delegate?.window else {
            return
        }
        window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }

    /// Display the alert in the current context
    ///
    /// - Parameter completion: Completion handler for
    func show(_ completion: (() -> Void)? = nil) {

        switch alertType {
        case .normal:
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
                completion?()
            })
            alertController?.addAction(action)
            showAlertController()

        case .custom(let buttonTittle):
            let action = UIAlertAction(title: buttonTittle, style: .cancel, handler: { _ in
                completion?()
            })
            alertController?.addAction(action)
            showAlertController()

        case .confirm:
            let actionNo = UIAlertAction(title: "Não", style: .cancel, handler: nil)
            
            let actionYes = UIAlertAction(title: "Sim", style: .default) { (_) in
                completion?()
            }

            alertController?.addAction(actionNo)
            alertController?.addAction(actionYes)
            
            let window = UIApplication.shared.delegate?.window ?? UIWindow()
            var topViewController = window?.rootViewController
            
            while let presented = topViewController?.presentedViewController {
                topViewController = presented
            }
            
            topViewController?.present(alertController!, animated: true, completion: nil)
        case .customConfirm(let dismissActionTitle, let confirmActionTitle):
            let dismissAction = UIAlertAction(title: dismissActionTitle, style: .cancel, handler: nil)
            
            let confirmAction = UIAlertAction(title: confirmActionTitle, style: .default) { (_) in
                completion?()
            }
            
            alertController?.addAction(dismissAction)
            alertController?.addAction(confirmAction)
            
            let window = UIApplication.shared.delegate?.window ?? UIWindow()
            var topViewController = window?.rootViewController
            
            while let presented = topViewController?.presentedViewController {
                topViewController = presented
            }
            
            topViewController?.present(alertController!, animated: true, completion: nil)
        case .block:
            let actionNo = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            
            let actionYes = UIAlertAction(title: blockText, style: .default) { (_) in
                completion?()
            }
            
            alertController?.addAction(actionNo)
            alertController?.addAction(actionYes)
            
            let window = UIApplication.shared.delegate?.window ?? UIWindow()
            var topViewController = window?.rootViewController
            
            while let presented = topViewController?.presentedViewController {
                topViewController = presented
            }
            
            topViewController?.present(alertController!, animated: true, completion: nil)
        }
    }
    
    /// Dismiss the alert
    func dismiss() {
        alertController?.dismiss(animated: true, completion: nil)
    }
}
