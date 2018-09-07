//
//  RootViewTests.swift
//  mvvmTests
//
//  Created by Ryan Wu on 2018-09-06.
//  Copyright © 2018 Ryan Wu. All rights reserved.
//

import XCTest
@testable import mvvm

class RootViewTests: XCTestCase {

    var sut: RootView!
    var viewModel: RootViewModelType!

    override func setUp() {
        super.setUp()
        viewModel = MockRootViewModel()
        sut = RootView.instantiate(viewModel: viewModel)
        _ = sut.view //trigger viewDidLoad
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testPageTitle() {
        XCTAssertEqual(sut.title, "Test viewDidLoad")

        sut.viewWillAppear(false)
        XCTAssertEqual(sut.title, "Test viewWillAppear")

        sut.viewDidAppear(false)
        XCTAssertEqual(sut.title, "Test viewDidAppear")
    }

    func testContentChanged() {
        viewModel.entryText = "Test Content"
        viewModel.contentChanged?("Test Content")
        viewModel.loaderChanged?(true)
        viewModel.loaderChanged?(false)
        viewModel.shouldOpenViewMore?(false)
        viewModel.shouldOpenViewMore?(true)

        //TODO:: valify the the change on view
    }

    class MockRootViewModel: RootViewModelType {
        var entryText: String? = "Test"

        func viewWillAppear() {
            pageTitleChanged?("Test viewWillAppear")
        }

        func viewDidLoad() {
            pageTitleChanged?("Test viewDidLoad")
        }

        func viewDidAppear() {
            pageTitleChanged?("Test viewDidAppear")
        }

        func tappedViewMore() {
            shouldOpenViewMore?(true)
        }

        var contentChanged: ((String?) -> Void)?

        var loaderChanged: ((Bool) -> Void)?

        var shouldOpenViewMore: ((Bool) -> Void)?

        var pageTitleChanged: ((String?) -> Void)?

    }
}
