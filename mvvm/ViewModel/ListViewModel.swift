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
    func cellViewModel(at indexPath: IndexPath) -> ConfigurableCellViewModel
    func numberOfRowsInSection(section: Int) -> Int
    var reloadList: (() -> Void)? { get set }
}

class ListViewModel: ListViewModelType {

    private let itemService: ItemService

    init(itemService: ItemService = ItemService()) {
        self.itemService = itemService
    }

    private var cellViewModels: [ConfigurableCellViewModel] = [] {
        didSet {
            self.reloadList?()
        }
    }

    // Inputs
    func viewDidLoad() {
        self.itemService.fetchItems { items in
            guard let items = items else {
                cellViewModels = []
                return
            }
            cellViewModels = items.map {
                if let date = $0.date {
                    return ListItemTwoCellViewModel(identifier: "ListItemTwoCell", title: $0.title, subTitle: $0.subTitle, date: date)
                } else {
                    return ListItemOneCellViewModel(identifier: "ListItemOneCell", title: $0.title, subTitle: $0.subTitle)
                }
            }
        }
    }

    // Outputs
    var reloadList: (() -> Void)?

    func cellViewModel(at indexPath: IndexPath) -> ConfigurableCellViewModel {
        return cellViewModels[indexPath.row]
    }

    func numberOfRowsInSection(section: Int) -> Int {
        return cellViewModels.count
    }

}
