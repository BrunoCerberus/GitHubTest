//
//  IMError.swift
//  GitHubTest
//
//  Created by bruno on 08/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation
    
struct IMError: Error {
    
    var title: String?
    var code: Int?
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }
    
    private var _description: String?
    
    init(title: String = "Verifique sua conexão com a internet e tente novamente",
         description: String? = nil, code: Int? = nil) {
        self.title = title
        self._description = description
        self.code = code
    }
}

