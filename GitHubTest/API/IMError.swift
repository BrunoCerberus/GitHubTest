//
//  IMError.swift
//  GitHubTest
//
//  Created by bruno on 08/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation

enum IMError: Error {
    case generic
    case connection
    case parse
}

extension IMError: Equatable {
    public var message: String {
        return localizedDescription
    }
    
    public var code: Int {
        switch self {
        case .generic:
            return 1
        case .connection:
            return 2
        case .parse:
            return 3
        }
    }
}

extension IMError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .generic:
            return "Algo deu errado, tente novamente"
        case .connection:
            return "Problema com a conexão"
        case .parse:
            return "Ocorreu um erro ao tentar efetivar a transação"
        }
    }
}
