//
//  ListView.swift
//  mvvm
//
//  Created by Ryan Wu on 2018-09-05.
//  Copyright © 2018 Ryan Wu. All rights reserved.
//

import UIKit

class ListView: UITableViewController {

    private var viewModel: ListViewModelType?

    static func instantiate(viewModel: ListViewModelType) -> ListView {
        let storeboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storeboard.instantiateViewController(withIdentifier: "ListView") as! ListView
        vc.viewModel = viewModel
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard var viewModel = viewModel else {
            fatalError("Missing view model dependencies")
        }
        viewModel.reloadList = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection(section: section) ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else {
            return UITableViewCell()
        }
        let identifier = viewModel.cellIdentifier(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let configurableCell = cell as? ConfigurableCell {
            let configurableCellVM = viewModel.cellViewModel(at: indexPath)
            configurableCell.configure(configurableCellVM)
        }
        return cell
    }
}
