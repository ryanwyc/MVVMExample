//
//  ListViewModelTests.swift
//  mvvmTests
//
//  Created by Ryan Wu on 2018-09-06.
//  Copyright © 2018 Ryan Wu. All rights reserved.
//

import XCTest
@testable import mvvm

class ListViewModelTests: XCTestCase {

    var sut: ListViewModel!

    override func setUp() {
        super.setUp()
        let successItemService = MockSuccessItemService()
        sut = ListViewModel(itemService: successItemService)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSuccessListItems() {
        var shouldReloadTriggered = false
        sut.reloadList = {
            shouldReloadTriggered = true
        }
        sut.viewDidLoad()
        XCTAssertTrue(shouldReloadTriggered)
        XCTAssertEqual(sut.numberOfRowsInSection(section: 0), 3)
        let firstRow = IndexPath(row: 0, section: 0)
        let firstRowViewModel = sut.cellViewModel(at: firstRow)
        XCTAssertEqual(firstRowViewModel.identifier, "ListItemTwoCell")
        let secondRow = IndexPath(row: 1, section: 0)
        let secondRowViewModel = sut.cellViewModel(at: secondRow)
        XCTAssertEqual(secondRowViewModel.identifier, "ListItemOneCell")
    }

    func testFailureListItems() {
        let failureItemService = MockFailureItemService()
        sut = ListViewModel(itemService: failureItemService)
        var shouldReloadTriggered = false
        sut.reloadList = {
            shouldReloadTriggered = true
        }
        sut.viewDidLoad()
        XCTAssertTrue(shouldReloadTriggered)
        XCTAssertEqual(sut.numberOfRowsInSection(section: 0), 0)
    }
    
}
