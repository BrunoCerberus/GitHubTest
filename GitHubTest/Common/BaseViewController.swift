//
//  BaseViewController.swift
//  GitHubTest
//
//  Created by bruno on 08/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout           = []
        self.extendedLayoutIncludesOpaqueBars = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    func displayGenericError() {
        DispatchQueue.main.async {
            AlertManager(with: self,
                         title: "Erro",
                         msg: "Ocorreu um erro inesperado. Tente novamente mais tarde.").showAlert()
        }
    }
    
    private func configureErrorViewFullScreenAnchors(_ errorView: UIView) {
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        errorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        errorView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        errorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func setupNavigationWithCloseButton() {
        navigationController?.navigationBar.barTintColor = .imNavigationBarTintColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.isTranslucent = false
        setupDismissLeftBarButtonItem()
    }
}
