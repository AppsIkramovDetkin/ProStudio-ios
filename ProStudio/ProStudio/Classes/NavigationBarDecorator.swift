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
		vc.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: PSFont.introBold.with(size: 17)]
		vc.navigationController?.navigationBar.tintColor = .white
		vc.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: PSFont.introBold.with(size: 33)]
	}
}
