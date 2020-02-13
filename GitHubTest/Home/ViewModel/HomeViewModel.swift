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
    func homeViewModelDidFinishFilter(_ viewModel: HomeViewModel)
}

class HomeViewModel {
    
    weak var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    weak var viewDelegate: HomeViewModelViewDelegate?
    
    var homeService: HomeService!
    
    var fetchList: [RepositoryElement] {
        return filteredList.isEmpty ? repoList : filteredList
    }
    
    var repoList: [RepositoryElement] = []
    var filteredList: [RepositoryElement] = []
    
    var numberOfRepos: Int {
        return filteredList.isEmpty ? repoList.count : filteredList.count
    }
    
    init() {
        homeService = HomeService()
    }
    
    func getRepository(in indexPath: IndexPath) -> RepositoryElement? {
        return fetchList[indexPath.row]
    }
    
    func showRepoDetail(with repo: RepositoryElement) {
        coordinatorDelegate?.homeViewModel(self, show: repo)
    }
    
    func fetchFilteredRepoList(values: [String]) {
        if values.isEmpty || values.contains("") {
            filteredList.removeAll()
            viewDelegate?.homeViewModelDidFinishFilter(self)
            return
        }
        
        var filterKey: Filters = .stars
        var orderKey: FiltersOrder = .descending
        
        values.forEach { value in
            if value == "CRESCENTE" || value == "DECRESCENTE" {
                orderKey = FiltersOrder(rawValue: value)!
            } else {
                filterKey = Filters(rawValue: value)!
            }
        }
        
        let localList = repoList
        let localFilteredList = localList.sorted(by: { [weak self] this, that in
            guard let self = self else { return false }
            if filterKey == .stars {
                return self.sorterForStars(this: this, that: that, order: orderKey)
            } else if filterKey == .watchers {
                return self.sorterForWatchers(this: this, that: that, order: orderKey)
            } else {
                return self.sorterForDate(this: this, that: that, order: orderKey)
            }
        })
        
        self.filteredList = localFilteredList
        viewDelegate?.homeViewModelDidFinishFilter(self)
    }
    
    private func sorterForStars(this: RepositoryElement,
                                that: RepositoryElement,
                                order: FiltersOrder) -> Bool {
        switch order {
        case .descending:
            return this.stargazersCount ?? 0 > that.stargazersCount ?? 0
        default:
            return this.stargazersCount ?? 0 < that.stargazersCount ?? 0
        }
    }
    
    private func sorterForWatchers(this: RepositoryElement,
                                   that: RepositoryElement,
                                   order: FiltersOrder) -> Bool {
        switch order {
        case .descending:
            return this.watchersCount ?? 0 > that.watchersCount ?? 0
        default:
            return this.watchersCount ?? 0 < that.watchersCount ?? 0
        }
    }
    
    private func sorterForDate(this: RepositoryElement,
                               that: RepositoryElement,
                               order: FiltersOrder) -> Bool {
        switch order {
        case .descending:
            return this.updatedAt ?? Date() < that.updatedAt ?? Date()
        default:
            return this.updatedAt ?? Date() > that.updatedAt ?? Date()
        }
    }
    
    func requesReposList(in page: Int = 1) {
        homeService.getRepos(with: page, onSuccess: { [weak self] repos in
            guard let self = self else { return }
            if page == 1 {
                self.repoList = repos
                self.filteredList.removeAll()
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
