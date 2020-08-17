//
//  AppDelegate.swift
//  CODEasterEgg
//
//  Created by Raphael Oliveira Chagas on 14/08/20.
//  Copyright © 2020 Raphael Oliveira Chagas. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		window = UIWindow(frame: UIScreen.main.bounds)
		let vc = MainViewController()
		window?.rootViewController = vc
		window?.makeKeyAndVisible()

		return true
	}
}

