//
//  CustomTextField.swift
//  ProStudio
//
//  Created by Zimma on 10/10/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
	
	var placeholderText: String?
	let border = CALayer()
	let width1: CGFloat = 2.0
	var isActive = false
	lazy var rightButton = UIButton()
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		styleTextField()
	}
	
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		
	}
	
	private lazy var rect = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
	override func layoutSubviews() {
		super.layoutSubviews()
	}
	
	let offset: CGFloat = -5
	
	override func textRect(forBounds bounds: CGRect) -> CGRect {
		var f = bounds
		f.origin.y = offset
		return f
	}

	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		var f = bounds
		f.origin.y = offset
		return f
	}

	override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
		var f = bounds
		f.origin.y = offset
		return f
	}
	
	private func styleTextField() {
		
		borderStyle = .none
		layer.masksToBounds = true
		border.borderWidth = width1
		border.frame = CGRect(x: 0, y: frame.size.height - width1, width: frame.size.width, height: 3)
		border.borderColor = PSColors.light.cgColor
		layer.addSublayer(border)
		
		font = PSFonts.textInTextField
		placeholder = placeholderText
		attributedPlaceholder = NSAttributedString(string: placeholderText ?? "", attributes: [.font: PSFonts.placeholder as Any])
	}
	
	func chengeBorderColor() {
		
		if isActive {
			border.borderColor = PSColors.light.cgColor
		} else {
			border.borderColor = PSColors.blue.cgColor
		}
		
		isActive = !isActive
	}
	
	func addRightButton() {
		
		let viewSize = frame.height * 0.65
		
		let view = UIView(frame: CGRect(x: 0, y: 0, width: viewSize, height: viewSize))
		
		
		rightButton.setImage(UIImage(named: "arrowDown"), for: .normal)
		rightButton.imageView?.contentMode = .scaleAspectFit
		rightButton.frame.size = CGSize(width: view.frame.width, height: view.frame.height)
		rightButton.center.y = view.center.y - 4
//		rightButton.frame.size = CGSize(width: view.frame.size.width, height: view.frame.size.height)
		
		view.addSubview(rightButton)
		
		rightView = view
		rightViewMode = .always
		
	}
	
}
