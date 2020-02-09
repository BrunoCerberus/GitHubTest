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
    func homeViewModel(_ viewModel: HomeViewModel, didFetch repos: Result<Any?, IMError>)
}

class HomeViewModel {
    
    weak var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    weak var viewDelegate: HomeViewModelViewDelegate?
    
    var homeService: HomeService!
    
    init() {
        homeService = HomeService()
    }
    
    func showRepoDetail() {
        coordinatorDelegate?.homeViewModel(self, show: nil)
    }
    
    func requesReposList() {
           homeService.getRepos(onSuccess: { [weak self] repos in
            guard let self = self else { return }
            self.viewDelegate?.homeViewModel(self, didFetch: .success(nil))
           }, onFail: { (error) in
            self.viewDelegate?.homeViewModel(self, didFetch: .failure(IMError(title: "Error",
                                                                              description: error,
                                                                              code: 0)))
           })
       }
}
