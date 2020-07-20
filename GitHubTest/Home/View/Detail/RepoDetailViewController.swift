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
    
    var viewModel: RepoDetailViewModelProtocol?
    private var disposeBag: DisposeBag = DisposeBag()
    
    let tableViewCorners: CGFloat = 30
    
    init(viewModel: RepoDetailViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
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
        detailTableView.tableFooterView = UIView(frame: CGRect(x: 0,
                                                               y: 0,
                                                               width: detailTableView.frame.size.width,
                                                               height: 1))
        shareButton
            .rx
            .tap
            .asDriver()
            .throttle(.seconds(2))
            .drive(onNext: { [weak self] in
                guard let repoUrl = self?.viewModel?.repoURL else {
                    self?.displayGenericError()
                    return
                }
                let vc = UIActivityViewController(activityItems: [repoUrl], applicationActivities: [])
                vc.popoverPresentationController?.barButtonItem = self?.navigationItem.rightBarButtonItem
                self?.present(vc, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        viewModel?
            .itemsDriver
            .drive(detailTableView.rx.items) {(cv, row, element) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = cv.dequeueBaseCell(with: element.cellType(), for: indexPath)
                cell.bindData(element)
                return cell
        }.disposed(by: disposeBag)
    }
    
    private func registerCells() {
        detailTableView.register(cellTypes: [
            MainRepoInfoTableViewCell.self,
            SecondaryInfoTableViewCell.self,
            ReadMeTableViewCell.self
        ])
    }
    
    private func roundCorners() {
        detailTableView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
    }
}
