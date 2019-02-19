//
//  SpacedLabel.swift
//  ProStudio
//
//  Created by Maxim Bezdenezhnykh on 19/02/2019.
//  Copyright © 2019 Nikita. All rights reserved.
//

import UIKit

class SpacedLabel: UILabel {
	
	func set(text: String, with spacing: CGFloat) {
		let atrStr = NSMutableAttributedString(string: text)
		let style = NSMutableParagraphStyle()
		style.lineSpacing = spacing
		let range = NSRange(location: 0, length: atrStr.length)
		atrStr.addAttribute(.paragraphStyle, value: style, range: range)
		
		attributedText = atrStr
	}
	
}
