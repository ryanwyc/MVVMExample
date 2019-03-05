//
//  ListViewModel.swift
//  mvvm
//
//  Created by Ryan Wu on 2018-09-05.
//  Copyright © 2018 Ryan Wu. All rights reserved.
//

import Foundation


typealias ListViewModelType = ListViewModelInput & ListViewModelOutput

protocol ListViewModelInput {
    // Inputs
    func viewDidLoad()
}

protocol ListViewModelOutput {
    // Outputs
    func cellViewModel(at indexPath: IndexPath) -> ConfigurableCellViewModel
    func numberOfRowsInSection(section: Int) -> Int
    var reloadList: (() -> Void)? { get set }
}

class ListViewModel: ListViewModelType {

    private let itemService: ItemProvider
    private let listItemsUseCase: ListItemsUseCase

    init(itemService: ItemProvider = ItemService(),
         listItemsUseCase: ListItemsUseCase = ListItemsUseCase()) {
        self.itemService = itemService
        self.listItemsUseCase = listItemsUseCase
    }

    private var cellViewModels: [ConfigurableCellViewModel] = [] {
        didSet {
            self.reloadList?()
        }
    }

    // Inputs
    func viewDidLoad() {
        self.itemService.fetchItems { [weak self] items in
            self?.cellViewModels = listItemsUseCase.createCellViewModels(with: items)
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
