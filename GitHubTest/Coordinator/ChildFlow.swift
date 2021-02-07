//
//  ChildFlow.swift
//  SkyApp
//
//  Created by Bruno Lopes on 31/08/20.
//  Copyright © 2020 Bruno. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/// Base Flow Steps
enum FlowSteps: Step {
    case stopped(object: Any?)
    case goBack
}

/// Used when you have a flow that needs to send signals to his parent flow
protocol ChildFlow: Flow {
    var selectedStep: BehaviorRelay<FlowSteps?> { get set }
}

extension ChildFlow {
    /// Starts a flow with a presentation type
    ///
    /// - Parameter presentation: The type do you want to present
    func start(with presentation: Presentation) {
        let view = start()
        
        switch presentation {
        case .modal(viewController: let viewController):
            navigation = IMNavigationViewController(rootViewController: rootViewController!)
            viewController.present(navigation!, animated: true, completion: nil)
        case .push(navigation: let navigation):
            self.navigation = navigation
            navigation.pushViewController(view, animated: true)
        case .none:
            navigation = IMNavigationViewController(rootViewController: view)
        }
        self.currentFlowViewControllers.append(view)
        watchNavigationItems()
    }
    
    /// Dealocate the memory of the current flow.
    func stop(_ deallocateNavigation: Bool = true) {
        cleanup()
        if rootViewController is BaseViewController {
            if let vc = rootViewController as? BaseViewController {
                //                vw.subviews.forEach { (sv) in sv.removeFromSuperview() }
                vc.base.disposeBag = nil
                debug("vc.base.disposeBag >>>>>>> \(vc)")
            }
        }
        
        rootViewController = nil
        if deallocateNavigation {
            navigation?.viewControllers.removeAll()
            navigation = nil
        }
        disposeBag = nil
        currentFlowViewControllers.removeAll()
    }
    
    /// Navigation monitor to deallocate useless view controller in the stack.
    /// Remove the flow when back button is pressed and user got out of the flow using navigation.
    private func watchNavigationItems() {
        navigation?.rx.didShow.asObservable().subscribe(onNext: { [weak self] viewController in
            if let nav = self?.navigation?.viewControllers {
                self?.currentFlowViewControllers = nav.filter({ (viewController) in
                    return (self?.currentFlowViewControllers.contains(viewController))!
                })
                
                if let root = self?.rootViewController {
                    if !nav.contains(root), self?.selectedStep.value == nil {
                        self?.selectedStep.accept(.goBack)
                    }
                }
//                debug("---------------CHILD FLOW-----------------")
//                debug("\n Total de items Navigation \(nav.count)")
//                debug("\n Total de items Coordinator \(String(describing: self?.currentFlowViewControllers.count))")
            }
        }).disposed(by: disposeBag!)
    }
}
