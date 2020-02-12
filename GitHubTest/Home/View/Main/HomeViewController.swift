//
//  HomeViewController.swift
//  GitHubTest
//
//  Created by bruno on 08/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var homeFlowLayout: UICollectionViewFlowLayout!
    
    private var viewModel: HomeViewModel!
    private var refreshControl: UIRefreshControl!
    private var bottomRefreshControl: UIRefreshControl!
    private var dispatchGroup: DispatchGroup!
    private var pageCount: Int = 1
    
    enum HomeSection: Int {
        case filter
        case repos
        
        static var count: Int { return 2 }
    }
    
    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        dispatchGroup = DispatchGroup()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDelegate = self
        title = "GitHub"
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        registerBarButtonItems()
        registerCells()
        addRefreshControl()
        refreshHome()
    }
    
    private func registerBarButtonItems() {
        let filterButton = UIBarButtonItem(image: UIImage(named: "ICO_FILTER"),
                                           landscapeImagePhone: nil,
                                           style: .done,
                                           target: self,
                                           action: #selector(showFilters))
        
        let searchButton = UIBarButtonItem(image: UIImage(named: "ICO_SEARCH"),
                                           landscapeImagePhone: nil,
                                           style: .done,
                                           target: self,
                                           action: #selector(bringTextField))
        
        filterButton.tintColor = .imBarButtonItems
        searchButton.tintColor = .imBarButtonItems
        
        navigationItem.rightBarButtonItems = [
            filterButton,
            searchButton
        ]
    }
    
    private func registerCells() {
        homeCollectionView.register(DefaultCollectionViewCell.self)
        homeCollectionView.register(RepoCollectionViewCell.self)
        homeCollectionView.register(FilterCarouselCollectionViewCell.self)
    }
    
    // MARK: Add a Activity Indicator in the homeCollectionView
    private func addRefreshControl() {
        refreshControl = UIRefreshControl()
        bottomRefreshControl = UIRefreshControl()
        refreshControl.tintColor = .imActivityIndicatorPullToRefresh
        bottomRefreshControl.tintColor = .imActivityIndicatorPullToRefresh
        refreshControl.addTarget(self, action: #selector(refreshHome), for: .valueChanged)
        bottomRefreshControl.addTarget(self, action: #selector(fetchMoreRepos), for: .valueChanged)
        homeCollectionView.refreshControl = refreshControl
        homeCollectionView.bottomRefreshControl = bottomRefreshControl
    }
    
    private func requests() {
        dispatchGroup.enter()
        viewModel.requesReposList()
    }
    
    @objc func refreshHome() {
        requests()
        
        dispatchGroup.notify(queue: .main) {
            DispatchQueue.main.async { [weak self] in
                self?.pageCount = 1
                self?.refreshControl.endRefreshing()
                self?.homeCollectionView.reloadData()
            }
        }
    }
    
    @objc func fetchMoreRepos() {
        dispatchGroup.enter()
        viewModel.requesReposList(in: pageCount+1)
        dispatchGroup.notify(queue: .main) { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.pageCount += 1
                self?.bottomRefreshControl.endRefreshing()
                self?.homeCollectionView.reloadData()
            }
        }
    }
    
    @objc private func showFilters() {
        viewModel.showFilters()
    }
    
    @objc private func bringTextField() {
           
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedRepo = viewModel.getRepository(in: indexPath) else { return }
        viewModel.showRepoDetail(with: selectedRepo)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HomeSection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch HomeSection(rawValue: section) {
        case .filter:
            return 1
        case .repos:
            return viewModel.numberOfRepos
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch HomeSection(rawValue: indexPath.section) {
        case .filter:
            return homeCollectionView.dequeueReusableCell(of: FilterCarouselCollectionViewCell.self, for: indexPath)
        case .repos:
            return homeCollectionView.dequeueReusableCell(of: RepoCollectionViewCell.self, for: indexPath) { [weak self] cell in
                guard let repo = self?.viewModel.getRepository(in: indexPath) else { return }
                cell.setup(repo: repo, index: indexPath.row)
            }
            
        default: return homeCollectionView.dequeueReusableCell(of: DefaultCollectionViewCell.self, for: indexPath)
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch HomeSection(rawValue: indexPath.section) {
        case .filter:
            return CGSize(width: collectionView.frame.width, height: 56)
        case .repos:
            return CGSize(width: collectionView.frame.width - 16, height: 155)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        switch HomeSection(rawValue: section) {
        case .filter:
            return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        case .repos:
            return UIEdgeInsets(top: 16, left: 8, bottom: 0, right: 8)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        switch HomeSection(rawValue: section) {
        case .filter:
            return .zero
        case .repos:
            return 10
        default:
            return .zero
        }
    }
}

extension HomeViewController: HomeViewModelViewDelegate {
    func homeViewModel(_ viewModel: HomeViewModel, didFetch result: Result<Any?, IMError>) {
      dispatchGroup.leave()
    }
}
