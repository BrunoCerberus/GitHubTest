//
//  String+Utils.swift
//  GitHubTest
//
//  Created by bruno on 08/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit

extension String {
    func remove(_ values: [String]) -> String {
        var stringValue = self
        let toRemove = stringValue.filter { values.contains("\($0)") }
        
        for value in toRemove {
            if let range = stringValue.range(of: "\(value)") {
                stringValue.removeSubrange(range)
            }
        }
        
        return stringValue
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func filterOnlyNumbers() -> String {
        return String(self.filter { "0123456789".contains($0) })
    }
    
    var removeCaracterSpecial: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
}
