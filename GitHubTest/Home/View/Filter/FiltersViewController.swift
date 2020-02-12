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
    
    let task = PublishSubject<Filter>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Filtrar"
        defaultBackButton()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        starsButton.checkState()
        watchersButton.checkState()
        dateButton.checkState()
        ascendingButton.checkState()
        descendingButton.checkState()
    }
    
    private func setup() {
        addButtonItem()
    }
    
    private func addButtonItem() {
        let clearButton = UIBarButtonItem(title: "Limpar",
                                          style: .plain,
                                          target: self,
                                          action: #selector(cleanFilters))
        clearButton.tintColor = .imBarButtonItems
        navigationItem.rightBarButtonItem = clearButton
    }
    
    @objc private func cleanFilters() {
        starsButton.removeImage()
        watchersButton.removeImage()
        dateButton.removeImage()
        ascendingButton.removeImage()
        descendingButton.removeImage()
    }
    @IBAction func selectButton(_ sender: FilterButton) {
        self.task.onNext(Filter(title: sender.titleLabel?.text ?? ""))
        sender.didSelect()
    }
}
