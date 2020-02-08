//
//  HomeViewController.swift
//  GitHubTest
//
//  Created by bruno on 08/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDelegate = self
    }
    
    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func showRepoDetail(_ sender: Any) {
        viewModel.showRepoDetail()
    }
}

extension HomeViewController: HomeViewModelViewDelegate {
    
}
