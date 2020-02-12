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
    func filter(with words: [String])
}

class FilterCarouselCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var carouselFilterCollectionView: UICollectionView!
    
    weak var delegate: FilterCarouselCollectionViewDelegate?
    
    var appdelegate: AppDelegate {
        return (UIApplication.shared.delegate as? AppDelegate)!
    }
    
    var tasks: Variable<[Filter]> = Variable([])
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        carouselFilterCollectionView.delegate = self
        carouselFilterCollectionView.register(FilterCollectionViewCell.self)
        
        bindAddFilter()
        bindCollectionView()
    }
    
    private func bindAddFilter() {
        appdelegate.appCoordinator.homeCoordinator?
            .filtersViewController.task.subscribe(onNext: { [weak self] task in
            self?.tasks.value.append(task)
        }).disposed(by: disposeBag)
    }
    
    private func bindCollectionView() {
        
        tasks.asObservable()
            .bind(to: carouselFilterCollectionView
                .rx
                .items(cellIdentifier: "FilterCollectionViewCell",
                       cellType: FilterCollectionViewCell.self)) { _, element, cell in
                
                        cell.setup(filterName: element.title)
                
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
    func removeFilterAt(index: Int) {
        //remove filter at the index and update
    }
}
