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
    func homeViewModelShowFilters(_ viewModel: HomeViewModel)
}

protocol HomeViewModelViewDelegate: AnyObject {
    func homeViewModel(_ viewModel: HomeViewModel, didFetch result: Result<Any?, IMError>)
}

class HomeViewModel {
    
    weak var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    weak var viewDelegate: HomeViewModelViewDelegate?
    
    var homeService: HomeService!
    
    var repoList: [RepositoryElement]!
    
    init() {
        homeService = HomeService()
    }
    
    func showRepoDetail() {
        coordinatorDelegate?.homeViewModel(self, show: nil)
    }
    
    func requesReposList() {
        homeService.getRepos(with: 1, onSuccess: { [weak self] repos in
            guard let self = self else { return }
            self.repoList = repos
            self.viewDelegate?.homeViewModel(self, didFetch: .success(nil))
            }, onFail: { _ in
                self.viewDelegate?.homeViewModel(self, didFetch: .failure(IMError.generic))
        })
    }
    
    func showFilters() {
        coordinatorDelegate?.homeViewModelShowFilters(self)
    }
}
