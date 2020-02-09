//
//  HomeService.swift
//  GitHubTest
//
//  Created by bruno on 09/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation

class HomeService: IMConfig<HomeAPI> {
    func getRepos(onSuccess: @escaping (Repository) -> Void, onFail: @escaping (String) -> Void) {
        fetch(target: .reposList, dataType: RepositoryElement.self) { (result, _) in
            switch result {
            case .success(let repos):
                onSuccess([repos])
            case .failure(let error):
                onFail(error.localizedDescription)
            }
        }
    }
}
