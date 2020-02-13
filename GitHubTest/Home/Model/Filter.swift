//
//  Filter.swift
//  GitHubTest
//
//  Created by Bruno on 12/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation

struct Filter {
    var title: String
    
}

extension Filter: Equatable {
    static func == (lhs: Filter, rhs: Filter) -> Bool {
        return lhs.title == rhs.title
    }
}
