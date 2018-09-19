//
//  PSCircularVIew.swift
//  circular-view
//
//  Created by Danil Detkin on 07/07/2018.
//  Copyright © 2018 DL. All rights reserved.
//

import UIKit

@IBDesignable
final class PSCircularView: UIView {
	
	private lazy var label: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = textColor
		label.text = "65%"
		label.textAlignment = .center
		label.font = UIFont.boldSystemFont(ofSize: 52.0)
		return label
	}()
	
	private lazy var circleView: UIView = {
		let circleView = UIView()
		circleView.translatesAutoresizingMaskIntoConstraints = false
		return circleView
	}()
	
	private lazy var staticCircleLayer: CAShapeLayer = {
		let circleLayer = CAShapeLayer()
		circleLayer.strokeColor = backFillColor.cgColor
		circleLayer.fillColor = UIColor.clear.cgColor
		circleLayer.lineWidth = lineWidth
		circleLayer.strokeStart = 0
		circleLayer.strokeEnd = 1
		return circleLayer
	}()
	
	private lazy var circleLayerGradientLayer: CAGradientLayer = {
		let circleLayerGradientLayer = CAGradientLayer()
		circleLayerGradientLayer.startPoint = CGPoint.init(x: 0, y: 1)
		circleLayerGradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
		circleLayerGradientLayer.colors = [UIColor.red, UIColor.green]
		return circleLayerGradientLayer
	}()
	
	private lazy var circleLayerGradientMask: CAShapeLayer = {
		let circleLayer = CAShapeLayer()
		circleLayer.strokeColor = strokeColor.cgColor
		circleLayer.fillColor = fillColor.cgColor
		circleLayer.lineWidth = lineWidth
		circleLayer.strokeStart = 0
		circleLayer.strokeEnd = 1
		return circleLayer
	}()
	
	@IBInspectable var textColor: UIColor = UIColor.init(netHex: 0x007FC9) {
		didSet {
			label.textColor = textColor
		}
	}
	
	@IBInspectable var strokeColor: UIColor = UIColor.init(netHex: 0xACD1FE) {
		didSet {
			circleLayerGradientMask.strokeColor = strokeColor.cgColor
		}
	}
	
	@IBInspectable var fillColor: UIColor = UIColor.clear {
		didSet {
			circleLayerGradientMask.fillColor = fillColor.cgColor
		}
	}
	
	@IBInspectable var backFillColor: UIColor = UIColor.init(netHex: 0xf1f1f1) {
		didSet {
			staticCircleLayer.strokeColor = backFillColor.cgColor
		}
	}
	
	@IBInspectable var lineWidth: CGFloat = 25 {
		didSet {
			updateLineWidths()
		}
	}
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		addCircleView()
		addLabel()
	}
	
	private func updateLineWidths() {
		circleLayerGradientMask.lineWidth = lineWidth
		staticCircleLayer.lineWidth = lineWidth
	}
	
	func animate(with value: CGFloat, duration: TimeInterval = 2) {
		var endValue = value
		if endValue > 1 {
			endValue = 1
		}
		
		let progress: CABasicAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
		progress.duration = duration
		progress.fromValue = circleLayerGradientMask.strokeStart
		progress.toValue = endValue
		
		progress.fillMode = kCAFillModeForwards
		progress.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
		progress.isRemovedOnCompletion = false
		circleLayerGradientMask.add(progress, forKey: "strokeEnd")
	}
	
	func set(_ configuration: PSCircularViewConfiguration) {
		self.lineWidth = configuration.lineWidth
		self.backFillColor = configuration.backStaticCircleColor
		self.fillColor = configuration.fillColor
		self.strokeColor = configuration.strokeColor
		self.textColor = configuration.textColor
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		addLayersForCircleView()
	}
	
	private func addLabel() {
		addSubview(label)
		let constraints: [NSLayoutConstraint] = {
			return NSLayoutConstraint.contraints(withNewVisualFormat: "H:|[label]|,V:|[label]|", dict: ["label": label])
		}()
		
		addConstraints(constraints)
	}
	
	private func addCircleView() {
		addSubview(circleView)
		let constraints: [NSLayoutConstraint] = {
			return NSLayoutConstraint.contraints(withNewVisualFormat: "H:|[circleView]|,V:|[circleView]|", dict: ["circleView": circleView])
		}()
		
		addConstraints(constraints)
	}
	
	private func addLayersForCircleView() {
		let center = CGPoint.init(x: circleView.bounds.width / 2, y: circleView.bounds.height / 2)
		let radius = circleView.bounds.width / 2 // for full cricle
		let circlePath = UIBezierPath(arcCenter: center,
																	radius: radius,
																	startAngle: CGFloat(Double.pi),
																	endAngle: CGFloat(Double.pi * 3),
																	clockwise: true)
		
		staticCircleLayer.path = circlePath.cgPath
		circleView.layer.addSublayer(staticCircleLayer)
		
		circleLayerGradientMask.path = circlePath.cgPath
		circleLayerGradientMask.lineCap = kCALineCapRound
//		circleLayerGradientLayer.mask = circleLayerGradientMask
		circleLayerGradientMask.frame = frame
		
		circleView.layer.addSublayer(circleLayerGradientMask)
		circleView.layer.addSublayer(circleLayerGradientLayer)
	}
	
}
