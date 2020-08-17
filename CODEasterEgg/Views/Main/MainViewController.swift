//
//  MainViewController.swift
//  CODEasterEgg
//
//  Created by Raphael Oliveira Chagas on 15/08/20.
//  Copyright © 2020 Raphael Oliveira Chagas. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

	@IBOutlet private weak var codesStackView: CodesStackView?
	@IBOutlet private weak var codeLabel: UILabel?
	@IBOutlet private weak var keysLabel: UILabel?
	@IBOutlet private weak var noseLabel: UILabel?
	@IBOutlet private weak var houseLabel: UILabel?
	@IBOutlet private weak var japaneseSymbolLabel: UILabel?
	@IBOutlet private weak var cleanButton: UIButton?

	let viewModel: MainViewModel

	init() {
		viewModel = MainViewModel()
		super.init(nibName: nil, bundle: Bundle(for: MainViewController.self))
		viewModel.delegate = self
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		codesStackView?.delegate = self
	}

	@IBAction func didTapClearButton(_ sender: Any) {
		resetAll()
	}

	func resetAll() {
		viewModel.resetAll()
		codesStackView?.resetAll()
	}
}

extension MainViewController: CodesStackViewDelegate {

	func needToRemove(textField: String) {
		viewModel.removeCode(forTextFieldKey: textField)
	}

	func didGetAllCode(code: String, textField: String) {
		viewModel.setCode(code: code, forTextFieldKey: textField)
	}
}

extension MainViewController: MainViewModelDelegate {

	func didGet(code: String) {
		codeLabel?.text = code
	}
}
