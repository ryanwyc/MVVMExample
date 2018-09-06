//
//  ListViewModel.swift
//  mvvm
//
//  Created by Ryan Wu on 2018-09-05.
//  Copyright © 2018 Ryan Wu. All rights reserved.
//

import Foundation

protocol ListViewModelType {
    // Inputs
    func viewDidLoad()

    // Outputs
    func cellIdentifier(at indexPath: IndexPath) -> String
    func cellViewModel(at indexPath: IndexPath) -> ConfigurableCellViewModel
    func numberOfRowsInSection(section: Int) -> Int
    var reloadList: (() -> Void)? { get set }
}

class ListViewModel: ListViewModelType {

    private var cellViewModels: [ConfigurableCellViewModel] = [] {
        didSet {
            self.reloadList?()
        }
    }

    // Inputs
    func viewDidLoad() {
        cellViewModels = [
            ListItemOneCellViewModel(identifier: "ListItemOneCell", title: "Good One", subTitle: "What is that?"),
            ListItemTwoCellViewModel(identifier: "ListItemTwoCell", title: "Good Two", subTitle: "What is that?", date: "2018-09-05"),
            ListItemOneCellViewModel(identifier: "ListItemOneCell", title: "Good One", subTitle: "What is that?"),
            ListItemTwoCellViewModel(identifier: "ListItemTwoCell", title: "Good Two", subTitle: "What is that?", date: "2018-09-05")
        ]
    }

    // Outputs
    var reloadList: (() -> Void)?

    func cellIdentifier(at indexPath: IndexPath) -> String {
        return cellViewModel(at: indexPath).identifier
    }

    func cellViewModel(at indexPath: IndexPath) -> ConfigurableCellViewModel {
        return cellViewModels[indexPath.row]
    }

    func numberOfRowsInSection(section: Int) -> Int {
        return cellViewModels.count
    }

}
