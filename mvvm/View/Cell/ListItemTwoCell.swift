//
//  ListItemTwoCell.swift
//  mvvm
//
//  Created by Ryan Wu on 2018-09-05.
//  Copyright © 2018 Ryan Wu. All rights reserved.
//

import UIKit

class ListItemTwoCell: UITableViewCell, ConfigurableCell {
    @IBOutlet weak private var title: UILabel!
    @IBOutlet weak private var subTitle: UILabel!
    @IBOutlet weak private var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(_ viewModel: ConfigurableCellViewModel) {
        guard let vm = viewModel as? ListItemTwoCellViewModel else { return }
        title.text = vm.title
        subTitle.text = vm.subTitle
        date.text = vm.date
    }
}
