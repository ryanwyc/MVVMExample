//
//  ListItemOneCellViewModel.swift
//  mvvm
//
//  Created by Ryan Wu on 2018-09-05.
//  Copyright © 2018 Ryan Wu. All rights reserved.
//

import Foundation

struct ListItemOneCellViewModel: ConfigurableCellViewModel {
    let identifier: String
    let title: String?
    let subTitle: String?
}
