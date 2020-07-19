//
//  IdentifierViewProtocol.swift
//  GitHubTestUITests
//
//  Created by Bruno on 7/19/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation

/// Protocol to sign enum with string reference elements of one test
public protocol IdentifierViewProtocol {
    /// The identifier for the View with Accessibility.
    var identifier: String { get }
}

public protocol LabelViewProtocol {
    /// The label of element
    var label: String { get }
}

public protocol ValueViewProtocol {
    /// The value of element
    var value: String { get }
}

/// Protocol to sign load view functions
public protocol UITestLoadViewProtocol {
    func loadView()
}

/// Protocol to Test visibility of all elements in the view
protocol UITestVisibilityProtocol {
    func testElementsExists()
}

/// Protocol to Test interaction of elements in the view
protocol UITestInteractableProtocol {
    func testElementsIsTappable()
}

/// Protocol to Test type of elements in the view
protocol UITestElementTypeProtocol {
    func testElementsIsDesignSystem()
}

/// Protocol to Test interactions of user (after loading data behaviours)
protocol UITestInputsProtocol {
    func testInputsSuccess()
    func testInputsFails()
    func testInputsChanges()
}

