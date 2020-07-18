//
//  RepoDetailViewController.swift
//  GitHubTest
//
//  Created by bruno on 08/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class RepoDetailViewController: BaseViewController {

    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var shareButton: UIButton!
    
    enum RepoDetailRow: Int {
        case mainInfo
        case secondaryInfo
        
        static var count: Int { return 3 }
    }
    
    var repo: RepositoryElement!
    private var disposeBag: DisposeBag = DisposeBag()
    
    let tableViewCorners: CGFloat = 30
    
    init(repo: RepositoryElement) {
        super.init(nibName: nil, bundle: nil)
        self.repo = repo
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Detalhe"
        setupLeftCloseBarButtonItem()
        roundCorners()
        registerCells()
        setupBind()
    }
    
    private func setupBind() {
        shareButton
            .rx
            .tap
            .asDriver()
            .throttle(.seconds(2))
            .drive(onNext: { [weak self] in
                guard let repoUrl = self?.repo.htmlURL else {
                    self?.displayGenericError()
                    return
                }
                let vc = UIActivityViewController(activityItems: [repoUrl], applicationActivities: [])
                vc.popoverPresentationController?.barButtonItem = self?.navigationItem.rightBarButtonItem
                self?.present(vc, animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
    
    private func registerCells() {
        detailTableView.register(MainRepoInfoTableViewCell.self)
        detailTableView.register(SecondaryInfoTableViewCell.self)
        detailTableView.registerHeaderFooter(ReadMeTableViewCell.self)
    }
    
    private func roundCorners() {
        detailTableView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
    }
}

extension RepoDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView =  detailTableView.dequeueReusableHeaderFooterView(of: ReadMeTableViewCell.self)
        footerView?.setup(repo: repo)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch RepoDetailRow(rawValue: indexPath.row) {
        case .none:
            return 1
        default:
            return UITableView.automaticDimension
        }
    }
}

extension RepoDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return RepoDetailRow.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch RepoDetailRow(rawValue: indexPath.row) {
        case .mainInfo:
            return detailTableView.dequeueReusableCell(of: MainRepoInfoTableViewCell.self,
                                                       for: indexPath) { [weak self] cell in
                                                        guard let self = self else { return }
                                                        cell.setup(repo: self.repo)
            }
        case .secondaryInfo:
            return detailTableView.dequeueReusableCell(of: SecondaryInfoTableViewCell.self,
                                                       for: indexPath) { [weak self] cell in
                                                        guard let self = self else { return }
                                                        cell.setup(repo: self.repo)
            }
            
        case .none:
            return UITableViewCell()
        }
    }
}
