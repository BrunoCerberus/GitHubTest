//
//  HomeCoordinator.swift
//  GitHubTest
//
//  Created by bruno on 08/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa

final class HomeCoordinator: BaseCoordinator {
    
    typealias V = HomeViewController
    
    var window: UIWindow
    var view: HomeViewController?
    var navigation: IMNavigationViewController?
    var presentationType: PresentationType?
    var viewModel: HomeViewModel!
    private var disposeBag: DisposeBag = DisposeBag()
    
    var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    lazy var screenWidth: CGFloat = {
        return UIScreen.main.bounds.width
    }()
    
    var filtersViewController: FiltersViewController = FiltersViewController()
    
    func start() {
        viewModel = HomeViewModel()
        viewModel
            .selectedStep
            .asDriver()
            .drive(onNext: { [weak self] step in
                guard let step = step else { return }
                switch step {
                case .detail(let repository):
                    self?.showRepoDetail(repository)
                case .filter:
                    self?.showFilters()
                }
            }).disposed(by: disposeBag)
        
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
        let viewModel = RepoDetailViewModel(repo: repo)
        let detailViewController = RepoDetailViewController(viewModel: viewModel)
        let destinationNavigationController = IMNavigationViewController(rootViewController: detailViewController)
        navigationController.present(destinationNavigationController, animated: true, completion: nil)
    }
    
    @objc private func showFilters() {
        guard let navigationController = navigation else { return }
        navigationController.pushViewController(filtersViewController, animated: true)
    }
}
