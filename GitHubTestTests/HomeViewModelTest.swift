//
//  HomeViewModelTest.swift
//  GitHubTestTests
//
//  Created by Bruno on 13/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import RxSwift
import RxCocoa
import XCTest
@testable import GitHubTest

class HomeViewModelTest: XCTestCase {
    
    private var viewModel: HomeViewModel?
    
    var didFetch: Bool = false
    var didFinishFilter: Bool = false
    var showRepoDetail: Bool = false
    var showFilter: Bool = false
    private var disposeBag: DisposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        
        viewModel = HomeViewModel()
    }
    
    func testDelegates() {
        XCTAssertNotNil(viewModel)
        viewModel?.delegate = self
        
        XCTAssertNotNil(viewModel?.delegate)
        XCTAssertNotNil(viewModel?.homeService)
        
        viewModel?
            .selectedStep
            .asDriver()
            .drive(onNext: { [weak self] step in
                guard let step = step else { return }
                switch step {
                case .detail( _):
                    self?.showRepoDetail = true
                case .filter:
                    self?.showFilter = true
                }
            }).disposed(by: disposeBag)
        
        
        viewModel?.navigate(to: .detail(RepositoryElement([:])!))
        viewModel?.navigate(to: .filter)
        
        viewModel?.delegate?.homeViewModel(viewModel!, didFetch: .success(nil))
        viewModel?.delegate?.homeViewModelDidFinishFilter(viewModel!)
        
        XCTAssertTrue(didFetch)
        XCTAssertTrue(didFinishFilter)
        XCTAssertTrue(showRepoDetail)
        XCTAssertTrue(showFilter)
    }
    
    func testRequest() {
        XCTAssertNotNil(viewModel)
        XCTAssertNotNil(viewModel?.homeService)
        
        let expectation = self.expectation(description: "Repo request")
        
        //not using any mock, i didn't had time to implement it
        viewModel?.homeService.getRepos(onSuccess: { [weak self] repos in
            guard let self = self else {
                XCTFail()
                return
            }
            
            XCTAssertNotNil(repos)
            XCTAssertGreaterThan(repos.count, 0, "repo?s must be greater than 0")
            XCTAssertNotNil(self.viewModel?.numberOfRepos)
            XCTAssertNotNil(self.viewModel?.fetchList)
            XCTAssertNotNil(self.viewModel?.filteredList)
            XCTAssertNotNil(self.viewModel?.repoList)
            XCTAssertNotNil(self.viewModel?.numberOfRepos)
            XCTAssertEqual(self.viewModel?.filteredList.count, 0, "filtered repos must be 0 at this point")
            expectation.fulfill()
            
        }) { _ in
            XCTFail()
        }
        
        waitForExpectations(timeout: 20, handler: nil)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
}

extension HomeViewModelTest: HomeViewModelViewDelegate {
    func homeViewModel(_ viewModel: HomeViewModel, didFetch result: Result<Any?, IMError>) {
        didFetch = true
    }
    
    func homeViewModelDidFinishFilter(_ viewModel: HomeViewModel) {
        didFinishFilter = true
    }
}
