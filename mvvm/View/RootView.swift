//
//  RootView.swift
//  mvvm
//
//  Created by Ryan Wu on 2018-09-05.
//  Copyright © 2018 Ryan Wu. All rights reserved.
//

import UIKit

class RootView: UIViewController {

    @IBOutlet weak private var entryTextField: UITextField!
    @IBOutlet weak private var contentLabel: UILabel!
    @IBOutlet weak private var loadingIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak private var viewMoreButton: UIButton!

    private var viewModel: RootViewModelType?

    static func instantiate(viewModel: RootViewModelType) -> RootView {
        let storeboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storeboard.instantiateViewController(withIdentifier: "RootView") as! RootView
        vc.viewModel = viewModel
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        entryTextField.addTarget(self, action: #selector(entryTextFieldDidChange), for: .editingChanged)
        entryTextField.delegate = self
        viewMoreButton.addTarget(self, action: #selector(navToListView), for: .touchUpInside)
        setupViewModelBinding()
        viewModel?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewWillAppear()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.viewDidAppear()
    }

    @objc private func entryTextFieldDidChange() {
        viewModel?.entryText = entryTextField.text
    }

    @objc private func navToListView() {
        viewModel?.tappedViewMore()
    }

    private func setupViewModelBinding() {
        viewModel?.contentChanged = { [weak self] text in
            DispatchQueue.main.async {
                self?.contentLabel.text = text
            }
        }

        viewModel?.loaderChanged = { [weak self] shouldShow in
            DispatchQueue.main.async {
                if shouldShow {
                    self?.loadingIndicatorView.startAnimating()
                } else {
                    self?.loadingIndicatorView.stopAnimating()
                }
            }
        }

        viewModel?.shouldOpenViewMore = { [weak self] shouldOpen in
            if shouldOpen {
                let view = ListView.instantiate(viewModel: ListViewModel())
                self?.navigationController?.pushViewController(view, animated: true)
            } else {
                print("NOT ALLOW TO OPEN")
            }
        }

        viewModel?.pageTitleChanged = { [weak self] title in
            self?.title = title
        }
    }
}

extension RootView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        entryTextField.resignFirstResponder()
        return true
    }
}
