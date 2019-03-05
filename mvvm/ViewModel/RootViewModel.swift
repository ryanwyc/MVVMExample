//
//  RootViewModel.swift
//  mvvm
//
//  Created by Ryan Wu on 2018-09-05.
//  Copyright © 2018 Ryan Wu. All rights reserved.
//

import Foundation

protocol RootViewModelType {
    var inputs: RootViewModelInput { get }
    var outputs: RootViewModelOutput { get set }
}

protocol RootViewModelInput {
    // Inputs
    func enter(text: String?)
    func viewWillAppear()
    func viewDidLoad()
    func viewDidAppear()
    func tappedViewMore()
}

protocol RootViewModelOutput {
    // Outputs
    var contentChanged: ((String?) -> Void)? { get set }
    var loaderChanged: ((Bool) -> Void)? { get set }
    var shouldOpenViewMore: ((Bool) -> Void)? { get set }
    var pageTitleChanged: ((String?) -> Void)? { get set }
}

class RootViewModel: RootViewModelType, RootViewModelInput, RootViewModelOutput {

    private let searchService: SearchProvider
    private var counter = 0

    var inputs: RootViewModelInput {
        return self
    }
    var outputs: RootViewModelOutput {
        get {
            return self
        }
        set {
            // no use
        }
    }

    // Inputs
    func enter(text: String?) {
        if let entryText = text {
            self.loaderChanged?(true)
            print("Searching terms \(entryText)")
            searchService.search(terms: entryText) { [weak self] response in
                self?.loaderChanged?(false)
                self?.contentChanged?(response)
            }
        }
    }
    
    func viewWillAppear() {
        pageTitleChanged?("MVVM View Will Appear")
    }

    func viewDidLoad() {
        pageTitleChanged?("MVVM View Loaded")
    }

    func viewDidAppear() {
        pageTitleChanged?("MVVM View")
    }

    func tappedViewMore() {
        // tapped second times to open
        self.shouldOpenViewMore?(counter > 1)
        counter += 1
    }

    // Outputs
    var contentChanged: ((String?) -> Void)?
    var loaderChanged: ((Bool) -> Void)?
    var shouldOpenViewMore: ((Bool) -> Void)?
    var pageTitleChanged: ((String?) -> Void)?

    init(searchService: SearchProvider = SearchService()) {
        self.searchService = searchService
    }

}
