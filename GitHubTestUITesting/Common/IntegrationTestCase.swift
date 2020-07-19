//
//  IntegrationTestCase.swift
//  GitHubTestUITests
//
//  Created by Bruno on 7/19/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation
import XCTest
import KIF
@testable import GitHubTest

protocol IntegrationTestCaseProtocol {
    func withLabel(_ label: LabelViewProtocol) -> KIFUIViewTestActor?
    func withIdentifier(_ identifier: IdentifierViewProtocol) -> KIFUIViewTestActor?
}

/// IntegrationTetCase - stubs and KIF functions
internal class IntegrationTestCase: KIFTestCase {
    let stubs = StubsNetworking()
    let bundleIdentifier = "bruno.GitHubTest"
    var application: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    
    lazy var appCoordinator: AppCoordinator? = {
        let appCoordinator = application?.appCoordinator
        return appCoordinator
    }()
    
    override func setUp() {
        super.setUp()
        stubs.setup()
        // Run the test animations super fast!!!
        KIFTypist.setKeystrokeDelay( 0.0025)
        KIFTestActor.setDefaultAnimationStabilizationTimeout(0.1)
        KIFTestActor.setDefaultAnimationWaitingTimeout(0.5)
        KIFTestActor.setDefaultTimeout(TimeInterval(3.0))
        // KIFTestActor.setStepDelay(0.5)
    }
    
    override func tearDown() {
        super.tearDown()
        stubs.clear()
        appCoordinator?.window.rootViewController?.presentedViewController?.dismissAnimated()
   }
    
    override func beforeEach() {
        super.beforeEach()
        UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
        UserDefaults.standard.removeObject(forKey: String(describing: HomeViewController.self))

    }
    
    override func afterEach() {
        super.afterEach()
         //clear user status
        UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)

    }
}

extension IntegrationTestCase {
    func tester(_ file: String = #file, _ line: Int = #line) -> KIFUIViewTestActor {
        return KIFUIViewTestActor(inFile: file, atLine: line, delegate: self)
    }
    
    func testerActor(file: String = #file, _ line: Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    
    func system(_ file: String = #file, _ line: Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
    
    func screenshot(line: UInt, name: String, _ desc: String = "") {
        try? UIApplication.shared.writeScreenshot(forLine: line, inFile: name, description: desc)
    }
    
    func findElement(_ label: String) -> Bool {
        do {
            try testerActor().tryFindingView(withAccessibilityLabel: label)
            return true
        } catch {
            return false
        }
    }
}

