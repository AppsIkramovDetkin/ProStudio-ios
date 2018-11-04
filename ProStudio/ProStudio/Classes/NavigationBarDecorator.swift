//
//  NavigationBarDecorator.swift
//  ProStudio
//
//  Created by Danil Detkin on 03/11/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit

class NavigationBarDecorator {
	static func decorate(_ vc: UIViewController) {
		vc.navigationController?.navigationBar.barTintColor = PSColor.cerulean
		let atrs = [NSAttributedString.Key.foregroundColor: UIColor.white]
		vc.navigationController?.navigationBar.titleTextAttributes = atrs
		vc.navigationController?.navigationBar.tintColor = .white
		vc.navigationController?.navigationBar.largeTitleTextAttributes = atrs
	}
}
