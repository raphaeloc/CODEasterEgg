//
//  LocalizedLabel.swift
//  CODEasterEgg
//
//  Created by Raphael Oliveira Chagas on 15/08/20.
//  Copyright © 2020 Raphael Oliveira Chagas. All rights reserved.
//

import UIKit

class LocalizedLabel : UILabel {

	@IBInspectable var keyValue: String {
		get {
			return self.text ?? String()
		}
		set(value) {
			self.text = value.localizedStringKey()
		}
	}
}
