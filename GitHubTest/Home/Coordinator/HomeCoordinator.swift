//
//  HomeCoordinator.swift
//  GitHubTest
//
//  Created by bruno on 08/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit

final class HomeCoordinator: BaseCoordinator {
    
    typealias V = HomeViewController
    
    var window: UIWindow
    var view: HomeViewController?
    var navigation: IMNavigationViewController?
    var presentationType: PresentationType?
    var viewModel: HomeViewModel!
    
    var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    // MARK: Controllers
    private var detailViewController: RepoDetailViewController!
    
    func start() {
        viewModel = HomeViewModel()
        viewModel.coordinatorDelegate = self
        view = HomeViewController(viewModel: viewModel)
        
        navigation = IMNavigationViewController(rootViewController: view!)
        window.rootViewController = navigation
    }
    
    func stop() {
        view = nil
        navigation = nil
        presentationType = nil
    }
    
    required init(window: UIWindow) {
        self.window = window
    }
    
    private func showRepoDetail(_ repo: Any?) {
        guard let navigationController = navigation else { return }
        detailViewController = RepoDetailViewController()
        navigationController.present(detailViewController, animated: true, completion: nil)
    }
}

extension HomeCoordinator: HomeViewModelCoordinatorDelegate {
    func homeViewModel(_ viewModel: HomeViewModel, show repoDetail: Any?) {
        showRepoDetail(repoDetail)
    }
}
