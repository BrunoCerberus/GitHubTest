//
//  Flow.swift
//  SkyApp
//
//  Created by Bruno Lopes on 31/08/20.
//  Copyright © 2020 Bruno. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/// Represents the way you want to show your screen
enum Presentation {
    case modal(viewController: UIViewController)
    case push(navigation: IMNavigationViewController)
    case none
}

/// Basic representation of a flow
protocol Flow: AnyObject {
    associatedtype BaseView: UIViewController
    var disposeBag: DisposeBag? { get set }
    var navigation: IMNavigationViewController? { get set }
    var rootViewController: BaseView? { get set }
    var currentFlowViewControllers: [UIViewController] { get set }
    func start(with presentation: Presentation)
    func start() -> UIViewController
    func stop()
    func cleanup()
    func next(screen: UIViewController, animated: Bool)
}

extension Flow {
    
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
    
    /// Start that give the instatiated rootViewController from a flow.
    /// Is usefull when you use a component that needs a ViewVontroller to fill it
    ///
    /// - Returns: UIViewController - The rootviewcontroller from flow
    func start() -> UIViewController {
        guard let view = rootViewController else { fatalError("The view must be instantiated before start") }
        return view
    }
    
    /// A helper to move to next screen without the need to write navigation push
    /// It appends the given viewController
    ///
    /// - Parameter screen:
    func next(screen: UIViewController, animated: Bool = true) {
        currentFlowViewControllers.append(screen)
        navigation?.pushViewController(screen, animated: animated)
    }
    
    /// Dealocate the memory of the current flow.
    func stop() {
        if rootViewController is BaseViewController {
            if let vc = rootViewController as? BaseViewController {
//                vw.subviews.forEach { (sv) in sv.removeFromSuperview() }
                vc.base.disposeBag = nil
                debug("vc.base.disposeBag >>>>>>> \(vc)")
            }
        }
        
        rootViewController = nil
        navigation?.viewControllers.removeAll()
        navigation = nil
        disposeBag = nil
        currentFlowViewControllers.removeAll()
    }
    
    /// Point for dealocation of the memory of the customized flows and instances.
    func cleanup() {
        
    }
    
    /// Navigation monitor to deallocate useless view controller in the stack.
    private func watchNavigationItems() {
        navigation?.rx.willShow.asObservable().subscribe(onNext: { [weak self] viewController in
            if let nav = self?.navigation?.viewControllers {
                self?.currentFlowViewControllers = nav.filter({ (viewController) in
                    return (self?.currentFlowViewControllers.contains(viewController))!
                })
                
//                debug("---------------PARENT FLOW-----------------")
//                debug("\n Total de items Navigation \(nav.count)")
//                debug("\n Total de items Coordinator \(String(describing: self?.currentFlowViewControllers.count))")
            }
        }).disposed(by: disposeBag!)
    }
}
