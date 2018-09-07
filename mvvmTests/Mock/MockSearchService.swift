//
//  MockSearchService.swift
//  mvvmTests
//
//  Created by Ryan Wu on 2018-09-06.
//  Copyright © 2018 Ryan Wu. All rights reserved.
//

@testable import mvvm

class MockSuccessSearchService: SearchProvider {
    func search(terms: String, completion: @escaping (String) -> Void) {
        return completion("Results: \(terms)")
    }
}

class MockFailureSearchService: SearchProvider {
    func search(terms: String, completion: @escaping (String) -> Void) {
        return completion("Errors: search \(terms) failed")
    }
}
