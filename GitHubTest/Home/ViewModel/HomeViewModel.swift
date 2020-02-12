//
//  HomeViewModel.swift
//  GitHubTest
//
//  Created by bruno on 08/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation

protocol HomeViewModelCoordinatorDelegate: AnyObject {
    func homeViewModel(_ viewModel: HomeViewModel, show repoDetail: RepositoryElement)
    func homeViewModelShowFilters(_ viewModel: HomeViewModel)
}

protocol HomeViewModelViewDelegate: AnyObject {
    func homeViewModel(_ viewModel: HomeViewModel, didFetch result: Result<Any?, IMError>)
}

class HomeViewModel {
    
    weak var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    weak var viewDelegate: HomeViewModelViewDelegate?
    
    var homeService: HomeService!
    
    var repoList: [RepositoryElement] = []
    
    var numberOfRepos: Int {
        return repoList.count
    }
    
    init() {
        homeService = HomeService()
    }
    
    func getRepository(in indexPath: IndexPath) -> RepositoryElement? {
        return repoList[indexPath.row]
    }
    
    func showRepoDetail(with repo: RepositoryElement) {
        coordinatorDelegate?.homeViewModel(self, show: repo)
    }
    
    func requesReposList(in page: Int = 1) {
        homeService.getRepos(with: page, onSuccess: { [weak self] repos in
            guard let self = self else { return }
            if page == 1 {
                self.repoList = repos
            } else {
                self.repoList.append(contentsOf: repos)
            }
            self.viewDelegate?.homeViewModel(self, didFetch: .success(nil))
            }, onFail: { _ in
                self.viewDelegate?.homeViewModel(self, didFetch: .failure(IMError.generic))
        })
    }
    
    func showFilters() {
        coordinatorDelegate?.homeViewModelShowFilters(self)
    }
}
