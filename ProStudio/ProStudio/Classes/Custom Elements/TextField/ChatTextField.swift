//
//  ChatTextField.swift
//  ProStudio
//
//  Created by Hadevs on 19/11/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit

class ChatTextField: UITextField {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupPlaceholder()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupPlaceholder()
	}
	
	private func setupPlaceholder() {
		let attributes: [NSAttributedString.Key : Any] = [
			NSAttributedString.Key.font: PSFont.introBook.with(size: 13),
			NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5567498803, green: 0.5568943024, blue: 0.5770959854, alpha: 1)
			]
		attributedPlaceholder = NSAttributedString(string: "Введите сообщение", attributes: attributes)
	}
	
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        return rect(for: bounds)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        return rect(for: bounds)
    }
    
    func rect(for bounds: CGRect) -> CGRect {
        let rect = CGRect(x: 16, y: 0, width: bounds.width - 44 - 16, height: bounds.height)
        return rect
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        return rect(for: bounds)
    }
}
