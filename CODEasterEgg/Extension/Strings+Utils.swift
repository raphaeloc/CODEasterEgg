//
//  Strings+Utils.swift
//  CODEasterEgg
//
//  Created by Raphael Oliveira Chagas on 14/08/20.
//  Copyright © 2020 Raphael Oliveira Chagas. All rights reserved.
//

import Foundation

extension String {

	func localizedStringKey() -> String {
		return NSLocalizedString(self, comment: String())
	}
}
