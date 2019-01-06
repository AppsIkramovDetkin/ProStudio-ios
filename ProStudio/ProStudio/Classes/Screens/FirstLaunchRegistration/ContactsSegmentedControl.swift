//
//  ContactsSegmentedControl.swift
//  ProStudio
//
//  Created by Maxim Bezdenezhnykh on 07.07.2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit
import Foundation

@IBDesignable final class ContactsSegmentedControl: UIControl {
	
	// MARK: Private properties
	private var segments: [ContactsSegment] = [] {
		didSet {
			layoutSubviews()
			print(self.frame)
		}
	}
	
	//MARK: Public properties
	
	@IBInspectable public var selectColor: UIColor = .blue {
		didSet {
			setupUI()
		}
	}
	
	@IBInspectable public var defaultColor: UIColor = .gray {
		didSet {
			setupUI()
		}
	}
	
	@IBInspectable public var selectedSegment: Int = 0 {
		didSet {
			setupUI()
		}
	}
	
	public var font: UIFont = .systemFont(ofSize: 10) {
		didSet {
			setupUI()
		}
	}
	
	public var titles: [String] = [] {
		didSet {
			setupUI()
		}
	}
	
	public var images: [UIImage] = [] {
		didSet {
			setupUI()
		}
	}
	
	var bottomLine: UIView = UIView()
	// MARK: Private methods
	
	private func setupUI() {
		if titles.count == images.count && titles.count != 0 {
			bottomLine.backgroundColor = PSColor.veryLightPink
			addSubview(bottomLine)
			for view in segments {
				view.removeFromSuperview()
			}
			
			segments.removeAll()
			for i in 0...(titles.count - 1) {
				let segment = ContactsSegment(frame: CGRect.zero)
				segment.text = titles[i]
				segment.font = font
				segment.image = images[i].withRenderingMode(.alwaysTemplate)
				segment.iconView.tintColor = i == selectedSegment ? PSColor.cerulean : PSColor.coolGrey
				segment.selectColor = selectColor
				segment.defaultColor = defaultColor
				segment.isSelectedSegment = (selectedSegment == i) ? true : false
				self.addSubview(segment)
				segment.isUserInteractionEnabled = false
				segments.append(segment)
			}
		}
	}
	
	// MARK: Public methods
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupUI()
	}
	
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		setupUI()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		if segments.count != 0 {
			
			let segmentWidth = self.frame.width / CGFloat(segments.count)
			
			for i in 0...(segments.count - 1) {
				let origin = CGPoint(x: segmentWidth * CGFloat(i),
														 y: 0)
				let size = CGSize(width: segmentWidth,
													height: self.frame.height)
				segments[i].frame = CGRect(origin: origin, size: size)
			}
		}
		
		bottomLine.frame = CGRect(x: 0, y: frame.height - 2, width: frame.width, height: 2)
	}
	
	override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
		super.beginTracking(touch, with: event)
		
		let location = touch.location(in: self)
		
		for i in 0...(segments.count - 1) {
			if segments[i].frame.contains(location) {
				selectedSegment = i
				self.sendActions(for: .valueChanged)
				UIImpactFeedbackGenerator.init(style: .light).impactOccurred()
				break
			}
		}
		
		return false
	}
	
}

















