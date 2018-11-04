//
//  PSFont.swift
//  ProStudio
//
//  Created by Danil Detkin on 03/11/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit

enum PSFont {
	case introBook
	case introBold
}

extension PSFont {
	func with(size: CGFloat) -> UIFont {
		switch self {
		case .introBook: return UIFont(name: "Intro-Book", size: size)!
		case .introBold: return UIFont(name: "Intro-Bold", size: size)!
		}
	}
	static let headerText = UIFont(name: "Intro-Bold", size: 37)
	static let nameFont = UIFont(name: "Intro-Bold", size: 29.15)
	static let companyFont = UIFont(name: "Intro-Book", size: 18.45)
	static let textFieldFont = UIFont(name: "Intro-Book", size: 16)
	static let cellText = UIFont(name: "Intro-Regular", size: 16)
	static let exitButtonFont = UIFont(name: "Intro-Book", size: 20)
	static let segmentedFont = UIFont(name: "Intro-Light", size: 13)
}
