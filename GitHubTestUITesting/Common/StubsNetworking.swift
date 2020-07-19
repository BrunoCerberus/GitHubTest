//
//  StubsNetworking.swift
//  GitHubTestUITests
//
//  Created by Bruno on 7/19/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation
import OHHTTPStubs

public class StubsNetworking {
    
    let prodDomain = "api.github.com"
    
    func setup() {
        HTTPStubs.setEnabled(true)
        HTTPStubs.onStubActivation { (request: URLRequest, stub: HTTPStubsDescriptor, _: HTTPStubsResponse) in
            print("[OHHTTPStubs] Request to \(request.url!) has been stubbed with \(String(describing: stub))")
        }
    }
    
    func clear() {
        HTTPStubs.removeAllStubs()
    }
}

