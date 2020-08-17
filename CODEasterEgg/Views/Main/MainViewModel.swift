//
//  MainViewModel.swift
//  CODEasterEgg
//
//  Created by Raphael Oliveira Chagas on 15/08/20.
//  Copyright © 2020 Raphael Oliveira Chagas. All rights reserved.
//

import UIKit

protocol MainViewModelDelegate: class {
	func didGet(code: String)
}

class MainViewModel {

	var codes: [String: String] = [:]
	var finalCharacters: [Int: Character] = [:]
	var knowedKeys: [Character: Character] = [:]

	weak var delegate: MainViewModelDelegate?

	func removeCode(forTextFieldKey key: String) {
		codes.removeValue(forKey: key)
		verify()
	}

	func setCode(code: String, forTextFieldKey key: String) {
		codes[key] = code
		verify()
	}

	func resetAll() {
		codes.removeAll()
		finalCharacters.removeAll()
		knowedKeys.removeAll()
		delegate?.didGet(code: "\("default.withoutData".localizedStringKey())")
	}

	private func verify() {
		if self.codes.isEmpty {
			delegate?.didGet(code: "\("default.withoutData".localizedStringKey())")
			return
		}
		var codes: [String] = []

		codes = self.codes.map( { return $0.value } )

		let firstCode = codes.first ?? String()

		if codes.count == 1 {
			delegate?.didGet(code: firstCode)
			return
		}

		for code in codes {
			setNumbers(code)
		}

		setFinalCode(codes)
	}

	private func setNumbers(_ code: String) {
		var position = -1
		for character in code {
			position += 1
			if (Int("\(character)")) != nil {
				finalCharacters[position] = character
			}
		}
	}

	private func setFinalCode(_ codes: [String]) {
		var finalCode = codes.first ?? String()

		for code in codes {
			for character in finalCharacters {
				_ = set(char: character.value, inString: code.uppercased(), atIndex: character.key)
			}
		}

		for character in finalCharacters {
			finalCode = set(char: character.value, inString: finalCode.uppercased(), atIndex: character.key)
		}

		for knowedKey in knowedKeys where finalCode.contains(knowedKey.key) {
			finalCode = finalCode.replacingOccurrences(of: "\(knowedKey.key)", with: "\(knowedKey.value)")
		}

		delegate?.didGet(code: finalCode.uppercased())
	}


	private func set(char: Character, inString string: String, atIndex index: Int) -> String {
		var chars = Array(string)
		knowedKeys[chars[index]] = char
		chars[index] = char
		let modifiedString = String(chars)
		return modifiedString.uppercased()
	}
}

