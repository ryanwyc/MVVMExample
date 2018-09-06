//
//  MockItemService.swift
//  mvvmTests
//
//  Created by Ryan Wu on 2018-09-06.
//  Copyright © 2018 Ryan Wu. All rights reserved.
//

@testable import mvvm

class MockSuccessItemService: ItemService {
    override func fetchItems(completion: ([ListItem]?) -> Void) {
        let items = [
            ListItem(title: "Item #1", subTitle: "A good book", date: "2008-09-01"),
            ListItem(title: "Item #2", subTitle: "A fun toy", date: nil),
            ListItem(title: "Item #3", subTitle: "A cool dress", date: nil)
        ]
        completion(items)
    }
}

class MockFailureItemService: ItemService {
    override func fetchItems(completion: ([ListItem]?) -> Void) {
        completion(nil)
    }
}
