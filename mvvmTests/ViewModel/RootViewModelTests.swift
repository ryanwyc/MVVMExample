//
//  RootViewModelTests.swift
//  mvvmTests
//
//  Created by Ryan Wu on 2018-09-06.
//  Copyright © 2018 Ryan Wu. All rights reserved.
//

import XCTest
@testable import mvvm

class RootViewModelTests: XCTestCase {

    var sut:RootViewModel!

    override func setUp() {
        super.setUp()
        let successSearchService = MockSuccessSearchService()
        sut = RootViewModel(searchService: successSearchService)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testPageTitle() {
        sut.pageTitleChanged = { title in
            XCTAssertEqual(title, "MVVM View Loaded")
        }
        sut.viewDidLoad()

        sut.pageTitleChanged = { title in
            XCTAssertEqual(title, "MVVM View Will Appear")
        }
        sut.viewWillAppear()

        sut.pageTitleChanged = { title in
            XCTAssertEqual(title, "MVVM View")
        }
        sut.viewDidAppear()
    }

    func testSearchTextSuccess() {
        sut.contentChanged = { text in
            XCTAssertEqual(text, "Results: Test")
        }
        sut.entryText = "Test"
    }

    func testSearchTextFailure() {
        let failureSearchService = MockFailureSearchService()
        sut = RootViewModel(searchService: failureSearchService)
        sut.contentChanged = { text in
            XCTAssertEqual(text, "Errors: search Test failed")
        }
        sut.entryText = "Test"
    }

    func testLoader() {
        var loaderShowed = [Bool]()
        sut.loaderChanged = { shouldShow in
            loaderShowed.append(shouldShow)
        }
        sut.entryText = "Test Loader"
        XCTAssertEqual(loaderShowed, [true, false])
    }

    func testOpenViewMore() {
        var opened = [Bool]()
        sut.shouldOpenViewMore = { shouldOpen in
            opened.append(shouldOpen)
        }
        sut.tappedViewMore()
        sut.tappedViewMore()
        sut.tappedViewMore()
        XCTAssertEqual(opened, [false, false, true])
    }

}
