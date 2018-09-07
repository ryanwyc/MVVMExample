//
//  ListItemsUseCase.swift
//  mvvm
//
//  Created by Ryan Wu on 2018-09-07.
//  Copyright © 2018 Ryan Wu. All rights reserved.
//

import Foundation

class ListItemsUseCase {

    func createCellViewModels(with items: [ListItem]?) -> [ConfigurableCellViewModel] {
        guard let items = items else {
            return []
        }

        return items.map { item in
            let vm: ConfigurableCellViewModel
            if item.date == nil {
                vm = ListItemOneCellViewModel(title: item.title, subTitle: item.subTitle)
            } else {
                vm = ListItemTwoCellViewModel(title: item.title, subTitle: item.subTitle, date: item.date)
            }
            return vm
        }
    }

}
