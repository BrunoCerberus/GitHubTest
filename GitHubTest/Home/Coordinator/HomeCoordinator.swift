//
//  HomeCoordinator.swift
//  GitHubTest
//
//  Created by bruno on 08/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit
import Foundation

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
    
    lazy var screenWidth: CGFloat = {
        return UIScreen.main.bounds.width
    }()
    
    // MARK: Controllers
    var detailViewController: RepoDetailViewController!
    var filtersViewController: FiltersViewController = FiltersViewController()
    
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
    
    private func showRepoDetail(_ repo: RepositoryElement) {
        guard let navigationController = navigation else { return }
        detailViewController = RepoDetailViewController(repo: repo)
        let destinationNavigationController = IMNavigationViewController(rootViewController: detailViewController)
        navigationController.present(destinationNavigationController, animated: true, completion: nil)
    }
    
    @objc private func showFilters() {
        guard let navigationController = navigation else { return }
        navigationController.pushViewController(filtersViewController, animated: true)
    }
}

extension HomeCoordinator: HomeViewModelCoordinatorDelegate {
    func homeViewModelShowFilters(_ viewModel: HomeViewModel) {
        showFilters()
    }
    
    func homeViewModel(_ viewModel: HomeViewModel, show repoDetail: RepositoryElement) {
        showRepoDetail(repoDetail)
    }
}
