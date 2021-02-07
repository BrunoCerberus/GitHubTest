//
//  BaseViewController.swift
//  GitHubTest
//
//  Created by bruno on 08/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class VCComponents {
    var disposeBag: DisposeBag?  = DisposeBag()
}

protocol BaseViewControllerProtocol {
    var base: VCComponents { get }
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    
    var base: VCComponents = VCComponents()
    
    internal var baseViewModel: BaseViewModelProtocol?
    private(set) var isVisibleHUD = PublishSubject<Bool>()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindProperties()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func bindProperties() {
        guard let baseDisposeBag = base.disposeBag else { return }
        
        isVisibleHUD.subscribe(onNext: { [weak self] isLoading in
            if isLoading {
                self?.showHUD()
            } else {
                self?.hideHUD()
            }
        }).disposed(by: baseDisposeBag)
        
        self.baseViewModel?
            .stateError
            .drive(onNext: { [weak self] (state, message) in
                switch state {
                case .banner: break
                case .alert:
                    self?.showBasicAlert(title: message, message: "")
                case .placeHolder: break
                default: break
                }
            }).disposed(by: baseDisposeBag)
        
        self.baseViewModel?
            .successDriver
            .drive(onNext: { [weak self] (receivedSuccess) in
                if receivedSuccess {
                    self?.removeErrorView()
                }
            }).disposed(by: baseDisposeBag)
    }
    
    func removeErrorView() {
        
    }
    
    func displayGenericError() {
        DispatchQueue.main.async {
            AlertManager(with: self,
                         title: "Erro",
                         msg: "Ocorreu um erro inesperado. Tente novamente mais tarde.").showAlert()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // fixing keyboard toolbar
        view.endEditing(true)
    }
    
    deinit {
        debug("#### >>>> deinit: \(self)")
    }
}

// Delegate to inform the coordinator that the childFlow was dismissed
extension BaseViewController: UINavigationControllerDelegate {}

extension BaseViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
