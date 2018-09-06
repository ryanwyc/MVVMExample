//
//  ConfigurableCell.swift
//  mvvm
//
//  Created by Ryan Wu on 2018-09-05.
//  Copyright © 2018 Ryan Wu. All rights reserved.
//

import Foundation

protocol ConfigurableCellViewModel {
    var identifier: String { get }
}

protocol ConfigurableCell {
    func configure(_ viewModel: ConfigurableCellViewModel)
}
