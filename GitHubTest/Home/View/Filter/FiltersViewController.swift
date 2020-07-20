//
//  FiltersViewController.swift
//  GitHubTest
//
//  Created by bruno on 09/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class FiltersViewController: UIViewController {
    
    @IBOutlet weak var starsButton: FilterButton!
    @IBOutlet weak var watchersButton: FilterButton!
    @IBOutlet weak var dateButton: FilterButton!
    @IBOutlet weak var ascendingButton: FilterButton!
    @IBOutlet weak var descendingButton: FilterButton!
    @IBOutlet weak var applyButton: UIButton!
    
    let task = PublishSubject<Filter>()
    private var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Filtrar"
        defaultBackButton()
        setup()
        setupBind()
        configureAccessibility()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        starsButton.checkState()
        watchersButton.checkState()
        dateButton.checkState()
        ascendingButton.checkState()
        descendingButton.checkState()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func registerForPultToRefresh() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(cleanFilters),
                                               name: .pullToRefresh,
                                               object: nil)
    }
    
    private func configureAccessibility() {
        applyButton.isAccessibilityElement = true
        applyButton.accessibilityTraits = UIAccessibilityTraits.button
        applyButton.accessibilityLabel = "Apply Filter Button"
        applyButton.accessibilityHint = "Apply to filter the repository list"
    }
    
    private func setup() {
        addButtonItem()
        registerForPultToRefresh()
    }
    
    private func setupBind() {
        applyButton
            .rx
            .tap
            .asDriver()
            .throttle(.seconds(2))
            .drive(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
    }
    
    private func addButtonItem() {
        let clearButton = UIBarButtonItem(title: "Limpar",
                                          style: .plain,
                                          target: self,
                                          action: #selector(cleanFilters))
        clearButton.tintColor = .imBarButtonItems
        clearButton.isAccessibilityElement = true
        clearButton.accessibilityTraits = UIAccessibilityTraits.button
        clearButton.accessibilityLabel = "Clear Button"
        clearButton.accessibilityHint = "Clear the selected filter buttons"
        navigationItem.rightBarButtonItem = clearButton
    }
    
    @objc private func cleanFilters() {
        unselectFilterButtons()
        unselectOrderButtons()
    }
    
    private func unselectFilterButtons() {
        if starsButton.selectedState == .selected { self.task.onNext(Filter(title: starsButton.titleLabel?.text ?? "")) }
        if watchersButton.selectedState == .selected { self.task.onNext(Filter(title: watchersButton.titleLabel?.text ?? "")) }
        if dateButton.selectedState == .selected { self.task.onNext(Filter(title: dateButton.titleLabel?.text ?? "")) }
        
        starsButton.removeImage()
        watchersButton.removeImage()
        dateButton.removeImage()
    }
    
    private func unselectOrderButtons() {
        if ascendingButton.selectedState == .selected { self.task.onNext(Filter(title: ascendingButton.titleLabel?.text ?? "")) }
        if descendingButton.selectedState == .selected { self.task.onNext(Filter(title: descendingButton.titleLabel?.text ?? "")) }
        ascendingButton.removeImage()
        descendingButton.removeImage()
    }
    
    @IBAction func selectButton(_ sender: FilterButton) {
        switch sender {
        case starsButton, watchersButton, dateButton:
            if sender.selectedState == .unselected {
                unselectFilterButtons()
            }
        case ascendingButton, descendingButton:
            if sender.selectedState == .unselected {
                unselectOrderButtons()
            }
        default:break
        }
        
        self.task.onNext(Filter(title: sender.titleLabel?.text ?? ""))
        sender.didSelect()
    }
}
