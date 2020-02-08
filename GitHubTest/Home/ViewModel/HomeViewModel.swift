//
//  HomeViewModel.swift
//  GitHubTest
//
//  Created by bruno on 08/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation

protocol HomeViewModelCoordinatorDelegate: AnyObject {
    func homeViewModel(_ viewModel: HomeViewModel, show repoDetail: Any?)
}

protocol HomeViewModelViewDelegate: AnyObject {
    
}

class HomeViewModel {
    
    weak var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    weak var viewDelegate: HomeViewModelViewDelegate?
    
    func showRepoDetail() {
        coordinatorDelegate?.homeViewModel(self, show: nil)
    }
}
