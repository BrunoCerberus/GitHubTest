//
//  HomeStubsNetworking.swift
//  GitHubTestUITesting
//
//  Created by Bruno on 7/19/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation
import OHHTTPStubs

final class HomeStubsNetworking: StubsNetworking {
    
    override func setup() {
        super.setup()
        
        stubForListFetch()
    }
    
    override func clear() {
        super.clear()
    }
    
    func stubForListFetch() {
        stub(condition: isHost(prodDomain) && isPath("/orgs/octokit/repos?page=1&per_page=10")) { _ in
            let stubPath = OHPathForFile("repo_list.json", type(of: self))
            return fixture(filePath: stubPath!, status: 200, headers: ["Content-Type": "application/json"])
        }
    }
    
    func stubForListFetchFail() {
        stub(condition: isHost(prodDomain) && isPath("/v2/auth")) { _ in
            let stubPath = OHPathForFile("empty.json", type(of: self))
            return fixture(filePath: stubPath!, status: 404, headers: ["Content-Type": "application/json"])
        }
    }
}

