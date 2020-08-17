//
//  LocalizedButton.swift
//  CODEasterEgg
//
//  Created by Raphael Oliveira Chagas on 15/08/20.
//  Copyright © 2020 Raphael Oliveira Chagas. All rights reserved.
//

import UIKit

class LocalizedButton: UIButton {

	@IBInspectable var keyValue: String {
		get {
			return titleLabel?.text ?? String()
		}
		set(value) {
			setTitle(value.localizedStringKey(), for: .normal)
		}
	}
}
