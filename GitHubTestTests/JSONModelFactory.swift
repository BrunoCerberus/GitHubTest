//
//  JSONModelFactory.swift
//  GitHubTest
//
//  Created by Bruno on 7/19/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation

class JSONModelFactory {
    
    static func makeModel<T: Codable>(_: T.Type, fromJSON json: String) throws -> T {
        let bundle = Bundle(for: self)
        let filePath = bundle.url(
            forResource: json,
            withExtension: "json"
        )
        
        let content = try Data(contentsOf: filePath!)
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.FormatStyle.fullDateWithTimeZone.rawValue
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return try decoder.decode(
            T.self,
            from: content
        )
    }
}
