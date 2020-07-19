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
        
        XCTAssertNotNil(self.tester().usingIdentifier(HomeViewElements.home.identifier))
        XCTAssertNotNil(self.tester().usingIdentifier(HomeViewElements.filterButton.identifier))
        XCTAssertNotNil(self.tester().usingLabel(HomeViewElements.homeTitle.label))
    }
}

extension HomeViewTests: UITestElementTypeProtocol {
    func testElementsIsDesignSystem() {
        self.loadView()
        
        XCTAssertNotNil(self.tester().usingIdentifier(HomeViewElements.home.identifier)?.view as? UICollectionView)
        XCTAssertNotNil(self.tester().usingIdentifier(HomeViewElements.filterButton.identifier)?.view)
        XCTAssertNotNil(self.tester().usingIdentifier(HomeViewElements.homeTitle.label)?.view)
    }
}

extension HomeViewTests: UITestInteractableProtocol {
    func testElementsIsTappable() {
        self.loadView()
        
        self.tester().usingIdentifier(HomeViewElements.filterButton.identifier)?.waitForTappableView()
        self.tester().usingIdentifier(HomeViewElements.home.identifier)?.waitForTappableView()
        self.tester().usingIdentifier(HomeViewElements.home.identifier)?.swipe(in: .down)
        self.tester().usingIdentifier(HomeViewElements.home.identifier)?.swipe(in: .up)
        self.tester().usingIdentifier(HomeViewElements.home.identifier)?.pullToRefresh(withDuration: .inAboutTwoSeconds)
        self.tester().usingIdentifier(HomeViewElements.filterButton.identifier)?.tap()
    }
}
