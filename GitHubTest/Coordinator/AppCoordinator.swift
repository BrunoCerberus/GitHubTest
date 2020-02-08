//
//  AppCoordinator.swift
//  GitHubTest
//
//  Created by bruno on 08/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    
    var window: UIWindow
    var foregroundWindow: UIWindow
    
    var view: HomeViewController?
    var navigation: IMNavigationViewController?
    var presentationType: PresentationType?
    
    var homeCoordinator: HomeCoordinator?
    
    func start() {
        homeCoordinator = HomeCoordinator(window: window)
        homeCoordinator?.start()
    }
    
    func stop() {
        view = nil
        navigation = nil
        presentationType = nil
    }
    
    required init(window: UIWindow) {
        self.window = window
        self.window.backgroundColor = .imBackgroundComponent
        self.window.makeKeyAndVisible()
        self.foregroundWindow = UIWindow(frame: UIScreen.main.bounds)
    }
}
