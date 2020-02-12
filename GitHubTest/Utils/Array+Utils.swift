//
//  Array+Utils.swift
//  GitHubTest
//
//  Created by bruno on 12/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {

    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        if let index = firstIndex(of: object) {
            remove(at: index)
        }
    }
}
