//
//  CodesStackView.swift
//  CODEasterEgg
//
//  Created by Raphael Oliveira Chagas on 14/08/20.
//  Copyright © 2020 Raphael Oliveira Chagas. All rights reserved.
//

import UIKit

protocol CodesStackViewDelegate: class {
	func didGetAllCode(code: String, textField: String)
	func needToRemove(textField: String)
}

class CodesStackView: UIStackView {

	@IBOutlet private weak var firstCodeTextfield: UITextField?
	@IBOutlet private weak var secondCodeTextfield: UITextField?
	@IBOutlet private weak var thirdCodeTextfield: UITextField?

	weak var delegate: CodesStackViewDelegate?

	var lastCursorPosition: UITextPosition?

	let maxCodeSize = 8

	override func awakeFromNib() {
		super.awakeFromNib()

		firstCodeTextfield?.delegate = self
		secondCodeTextfield?.delegate = self
		thirdCodeTextfield?.delegate = self

		firstCodeTextfield?.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
		secondCodeTextfield?.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
		thirdCodeTextfield?.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)

		setup()
	}

	func setup() {
		firstCodeTextfield?.placeholder = NSLocalizedString("placeHolder.firstCode", comment: String())
		secondCodeTextfield?.placeholder = NSLocalizedString("placeHolder.second", comment: String())
		thirdCodeTextfield?.placeholder = NSLocalizedString("placeHolder.third", comment: String())
	}

	func resetAll() {
		firstCodeTextfield?.text = nil
		secondCodeTextfield?.text = nil
		thirdCodeTextfield?.text = nil
	}
}

extension CodesStackView: UITextFieldDelegate {

	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let langStr = Locale.current.languageCode ?? String()
		let houseKey = langStr == "pt" ? "C" : "H"
		if (string.uppercased() != "N" && string.uppercased() != houseKey && string.uppercased() != "J" && (Int(string)) == nil && string != String()) {
			return false
		}

		guard let text = textField.text, let correctRange = Range(range, in: text) else { return false }
		let newText = text.replacingCharacters(in: correctRange, with: string)
		let beginning = textField.beginningOfDocument
		lastCursorPosition = textField.position(from: beginning, offset: (range.location + string.count))

		return !(newText.count > maxCodeSize)
	}

	@objc
	func didChange(_ textField: UITextField) {
		textField.text = (textField.text ?? String()).uppercased()
		
		if let text = textField.text, text.count == maxCodeSize {
			delegate?.didGetAllCode(code: text, textField: textField.accessibilityIdentifier ?? String())
		} else {
			delegate?.needToRemove(textField: textField.accessibilityIdentifier ?? String())
		}

		guard let cursorPosition = lastCursorPosition else { return }
		textField.selectedTextRange = textField.textRange(from: cursorPosition, to: cursorPosition)
	}
}
