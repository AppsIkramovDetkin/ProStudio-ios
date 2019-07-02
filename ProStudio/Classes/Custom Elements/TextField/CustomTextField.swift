//
//  CustomTextField.swift
//  ProStudio
//
//  Created by Zimma on 10/10/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
	
	var placeholderText: String? {
		didSet {
			styleTextField()
		}
	}
	var placeholderFont = UIFont(name: "Intro-Book", size: 17)
		
	let border = CALayer()
	let width1: CGFloat = 2.0
	var isActive = false
	lazy var rightButton = UIButton()
	
	var discussionField: Bool = true {
		didSet {
			if discussionField {
				placeholderFont = UIFont(name: "Intro-Book", size: 17)
			} else {
				placeholderFont = PSFonts.placeholder
			}
			styleTextField()
		}
	}

	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		styleTextField()
	}

	private lazy var rect = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
	override func layoutSubviews() {
		super.layoutSubviews()
		border.frame.size.width = bounds.width
	}

	let offset: CGFloat = -5

	override func caretRect(for position: UITextPosition) -> CGRect {
		return CGRect.zero
	}
	
	override func textRect(forBounds bounds: CGRect) -> CGRect {
		var f = bounds
		f.origin.y = offset
		f.size.height -= offset
		return f
	}

	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		var f = bounds
		f.origin.y = offset
		f.size.height -= offset
		return f
	}

	override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
		if !discussionField {
			var f = bounds
			f.origin.y = offset
			f.size.height -= offset
			return f
		} else {
			return CGRect(x: 0, y: 0, width: bounds.width, height: 17)
		}
	}
	
	override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
		return CGRect(x: bounds.width-15, y: 0, width: 40, height: 30)
	}

	private func styleTextField() {

		borderStyle = .none
		layer.masksToBounds = true
		border.borderWidth = width1
		border.frame = CGRect(x: 0, y: frame.size.height - width1 - 6,
													width: frame.size.width, height: width1)
		border.borderColor = PSColors.light.cgColor
		layer.addSublayer(border)

		font = PSFonts.textInTextField
		placeholder = placeholderText
		attributedPlaceholder = NSAttributedString(string: placeholderText ?? "", attributes: [.font: placeholderFont as Any])
	}
	
	func chengeBorderColor() {

		if isActive {
			border.borderColor = PSColors.light.cgColor
			attributedPlaceholder = NSAttributedString(string: placeholderText ?? "", attributes: [.font: placeholderFont as Any, .foregroundColor: PSColors.light])
		} else {
			border.borderColor = PSColors.blue.cgColor
			attributedPlaceholder = NSAttributedString(string: placeholderText ?? "", attributes: [.font: placeholderFont as Any, .foregroundColor: PSColors.blue])
		}
		
		isActive = !isActive
	}

	func addRightButton() {

		let viewSize = frame.height * 0.75

		let view = UIView(frame: CGRect(x: 0, y: 0, width: viewSize, height: viewSize))


		rightButton.setImage(UIImage(named: "arrowDown")?.withRenderingMode(.alwaysTemplate), for: .normal)
		rightButton.tintColor = #colorLiteral(red: 0.8155472875, green: 0.8157331944, blue: 0.8358949423, alpha: 1)
		rightButton.imageEdgeInsets = UIEdgeInsets(top: 8, left: -10, bottom: 15, right: 20)
		rightButton.imageView?.contentMode = .scaleAspectFit
		rightButton.frame = view.frame

		view.addSubview(rightButton)
		
		rightView = view
		rightViewMode = .always

	}
	
}
