//
//  ListItemsUseCaseTests.swift
//  mvvmTests
//
//  Created by Ryan Wu on 2018-09-07.
//  Copyright © 2018 Ryan Wu. All rights reserved.
//

import XCTest
@testable import mvvm

class ListItemsUseCaseTests: XCTestCase {

    var sut: ListItemsUseCase!

    override func setUp() {
        super.setUp()
        sut = ListItemsUseCase()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testCreateViewModels() {
        let mockItems: [ListItem] = [
            ListItem(title: "test1", subTitle: "test1 sub", date: "2018-09-09"),
            ListItem(title: "test2", subTitle: "test2 sub", date: nil)
        ]

        let expectedViewModels: [ConfigurableCellViewModel] = [
            ListItemTwoCellViewModel(title: "test1", subTitle: "test1 sub", date: "2018-09-09"),
            ListItemOneCellViewModel(title: "test1", subTitle: "test1 sub")
        ]

        let viewModels = sut.createCellViewModels(with: mockItems)

        XCTAssertEqual(viewModels.count, expectedViewModels.count)
        XCTAssertEqual(viewModels[0].identifier, expectedViewModels[0].identifier)
        XCTAssertEqual(viewModels[1].identifier, expectedViewModels[1].identifier)
    }
    
}
