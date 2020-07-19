//
//  HomeViewTests.swift
//  GitHubTestUITesting
//
//  Created by Bruno on 7/19/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import XCTest
@testable import GitHubTest

class HomeViewTests: IntegrationTestCase {
    let homeStubs = HomeStubsNetworking()
    
    override func setUp() {
        super.setUp()
        homeStubs.setup()
    }
}

extension HomeViewTests: UITestLoadViewProtocol {
    func loadView() {
        appCoordinator?.start()
        tester().waitForAnimationsToFinish()
    }
}

extension HomeViewTests: UITestVisibilityProtocol {
    func testElementsExists() {
        self.loadView()
    }
}

extension HomeViewTests: UITestElementTypeProtocol {
    func testElementsIsDesignSystem() {
        self.loadView()
    }
}

extension HomeViewTests: UITestInteractableProtocol {
    func testElementsIsTappable() {
        self.loadView()
    }
}
