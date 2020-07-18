//
//  RepoDetailViewModel.swift
//  GitHubTest
//
//  Created by Bruno on 7/18/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol RepoDetailViewModelProtocol {
    var itemsDriver: Driver<[RepoDetailCellType]> { get }
    var repoURL: String? { get }
}

class RepoDetailViewModel: RepoDetailViewModelProtocol {
    
    var repo: RepositoryElement?
    
    var repoURL: String? {
        return repo?.htmlURL
    }
    
    var itemsDriver: Driver<[RepoDetailCellType]> {
        return itemsInput.asDriver()
    }
    
    private lazy var itemsInput: BehaviorRelay<[RepoDetailCellType]> = BehaviorRelay(value: [RepoDetailCellType]())
    
    init(repo: RepositoryElement) {
        self.repo = repo
        itemsInput.accept([
            .main(repo: repo),
            .secondary(repo: repo),
            .readMe(repo: repo)
        ])
    }
}
