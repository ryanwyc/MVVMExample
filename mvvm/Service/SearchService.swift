//
//  SearchService.swift
//  mvvm
//
//  Created by Ryan Wu on 2018-09-05.
//  Copyright © 2018 Ryan Wu. All rights reserved.
//

import Foundation

protocol SearchProvider {

    func search(terms: String, completion: @escaping (String)->Void)

}

class SearchService: SearchProvider {
    // To create cancelable tasks for demo purpose
    let queue = DispatchQueue(label: "Test")
    var work: DispatchWorkItem?
    func search(terms: String, completion: @escaping (String)->Void) {
        if let work = work, !work.isCancelled {
            work.cancel()
        }
        work = DispatchWorkItem(block: {
            completion("Results: \n\n\(terms)")
        })
        queue.asyncAfter(deadline: DispatchTime.now()+1, execute: work!)
    }
}
