//
//  BaseViewModel.swift
//  SkyApp
//
//  Created by Bruno Lopes on 31/08/20.
//  Copyright © 2020 Bruno. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum ErrorState {
    case banner
    case alert
    case placeHolder
    case none
}

protocol BaseViewModelProtocol {
    var messageErrorDriver: Driver<String> { get }
    var loading: Driver<Bool> { get }
    var mIsLoading: PublishSubject<Bool> { get }
    var stateError: Driver<(ErrorState, String)> { get }
    func navigateToForgotElectronicSignature()
    func navigateToForgotPassword()
    var successDriver: Driver<Bool> { get }
    var receivedSuccess: PublishSubject<Bool> { get }
}

class BaseViewModel: BaseViewModelProtocol {
    private let messageErrorSubject = PublishSubject<String>()
    var messageErrorDriver: Driver<String> {
        return messageErrorSubject.asDriver(onErrorJustReturn: "")
    }
    
    private let stateErrorSubject = PublishSubject<(ErrorState, String)>()
    var stateError: Driver<(ErrorState, String)> {
        return stateErrorSubject.asDriver(onErrorJustReturn: (.none, ""))
    }
    
    internal var mIsLoading = PublishSubject<Bool>()
    var loading: Driver<Bool> {
        return mIsLoading.asDriver(onErrorJustReturn: false)
    }
    
    internal var receivedSuccess = PublishSubject<Bool>()
    var successDriver: Driver<Bool> {
        return receivedSuccess.asDriver(onErrorJustReturn: false)
    }
    
    func handleError(error: Error) {
        var message = NSLocalizedString("modal-base-vm-generic-error", comment: "")
        guard let requestError = error as? IMError else {
            return
        }
        switch requestError {
        case .generic:
            message = IMError.generic.localizedDescription
        case .connection:
            message = IMError.connection.localizedDescription
        case .parse:
            message = IMError.parse.localizedDescription
        }
        messageErrorSubject.onNext(message)
    }
    
    func handleBadRequest(error: Error) {
        guard let requestError = error as? IMError else {
            return
        }
        switch requestError {
        case .generic:
            let message = IMError.generic.localizedDescription
            messageErrorSubject.onNext(message)
        case .parse:
            let message = IMError.parse.localizedDescription
            messageErrorSubject.onNext(message)
        default:
            handleError(error: error)
        }
    }
    
    func handleStateError(error: Error, state: ErrorState) {
        var message = NSLocalizedString("modal-base-vm-generic-error", comment: "")
        guard let requestError = error as? IMError else {
            return
        }
        switch requestError {
        case .generic:
            message = IMError.generic.localizedDescription
        case .parse:
            message = IMError.parse.localizedDescription
        case .connection:
            message = IMError.connection.localizedDescription
        }
        self.stateErrorSubject.onNext((state, message))
    }
    
    func navigateToForgotElectronicSignature() {
        debug("This method needs to be overridden")
    }
    
    func navigateToForgotPassword() {
        debug("This method needs to be overridden")
    }
}
