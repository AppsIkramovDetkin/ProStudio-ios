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
}
