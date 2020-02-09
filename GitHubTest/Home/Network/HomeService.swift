//
//  HomeService.swift
//  GitHubTest
//
//  Created by bruno on 09/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation

class HomeService: IMConfig<HomeAPI> {
    func getRepos(with page: Int = 1, onSuccess: @escaping ([RepositoryElement]) -> Void, onFail: @escaping (String) -> Void) {
        fetch(target: .reposList(page: page), dataType: [RepositoryElement].self) { (result, _) in
            switch result {
            case .success(let repos):
                onSuccess(repos)
            case .failure(let error):
                onFail(error.localizedDescription)
            }
        }
    }
}
