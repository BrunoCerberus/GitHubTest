//
//  FilterCarouselCollectionViewCell.swift
//  GitHubTest
//
//  Created by Bruno on 12/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol FilterCarouselCollectionViewDelegate: AnyObject {
    func performBatchUpdates(height: CGFloat)
}

class FilterCarouselCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var carouselFilterCollectionView: UICollectionView!
    
    weak var delegate: FilterCarouselCollectionViewDelegate?
    
    var appdelegate: AppDelegate {
        return (UIApplication.shared.delegate as? AppDelegate)!
    }
    
    var tasks: BehaviorRelay<[Filter]> = BehaviorRelay(value: [])
    private let disposeBag = DisposeBag()
    var filters: [Filter] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        carouselFilterCollectionView.delegate = self
        carouselFilterCollectionView.register(FilterCollectionViewCell.self)
        
        bindAddFilter()
        bindCollectionView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func bindAddFilter() {
        appdelegate.appCoordinator.homeCoordinator?
            .filtersViewController.task.subscribe(onNext: { [weak self] task in
                if (self?.tasks.value.map {$0.title})?.contains(task.title) ?? false {
                    self?.filters.remove(object: task)
                } else {
                    self?.filters.append(task)
                }
                self?.tasks.accept(self?.filters ?? [])
                if self?.tasks.value.count == 0 {
                    self?.delegate?.performBatchUpdates(height: 1)
                }
        }).disposed(by: disposeBag)
    }
    
    private func bindCollectionView() {
        
        tasks.asObservable()
            .bind(to: carouselFilterCollectionView
                .rx
                .items(cellIdentifier: "FilterCollectionViewCell",
                       cellType: FilterCollectionViewCell.self)) { [weak self] _, element, cell in
                
                        cell.setup(filterName: element.title)
                        cell.delegate = self
                        self?.delegate?.performBatchUpdates(height: 56)
                
        }.disposed(by: disposeBag)
    }
}

extension FilterCarouselCollectionViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = carouselFilterCollectionView.dequeueReusableCell(of: FilterCollectionViewCell.self,
                                                                    for: indexPath) as? FilterCollectionViewCell
        cell?.setup(filterName: tasks.value[indexPath.row].title)
        cell?.setNeedsLayout()
        cell?.layoutIfNeeded()
        let size: CGSize = (cell?.contentView
            .systemLayoutSizeFitting(UIView.layoutFittingCompressedSize))!
        return CGSize(width: size.width, height: 36)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension FilterCarouselCollectionViewCell: FilterCollectionViewDelegate {
    func removeFilterWith(name: String) {
        filters.remove(object: Filter(title: name))
        tasks.accept(self.filters)
        UserDefaults.standard.set(false, forKey: "\(name)-selected")
        if tasks.value.count == 0 {
            delegate?.performBatchUpdates(height: 1)
        }
    }
}
