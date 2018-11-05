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
		label.textColor = PSColors.textColorOff
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
		circleLayer.strokeColor = PSColors.staticCircleLayerColorOff.cgColor
		circleLayer.fillColor = UIColor.clear.cgColor
		circleLayer.lineWidth = backLineWidth
		circleLayer.strokeStart = 0
		circleLayer.strokeEnd = 1
		return circleLayer
	}()
	
	private let progressView: UIProgressView = {
		let progress = UIProgressView()
		return progress
	}()
	
	private lazy var circleLayerGradientMask: CAShapeLayer = {
		let circleLayer = CAShapeLayer()
		circleLayer.strokeColor = PSColors.circleLayerGradientMask.cgColor
		circleLayer.fillColor = UIColor.clear.cgColor
		circleLayer.lineWidth = lineWidth
		circleLayer.strokeStart = 0
		circleLayer.strokeEnd = 1
		
		circleLayer.shadowColor = PSColors.circleLayerGradientMaskShadow.cgColor
		circleLayer.shadowRadius = 8.0
		circleLayer.shadowOpacity = 0.3
		circleLayer.shadowOffset = CGSize(width: 4, height: 2)
		return circleLayer
	}()
	
	@IBInspectable var lineWidth: CGFloat = 25 {
		didSet {
			updateLineWidths()
		}
	}
	
	@IBInspectable var backLineWidth: CGFloat = 20 {
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
		
		label.text = "\(Int(endValue * 100))%"
		if value > 0 {
			staticCircleLayer.strokeColor = PSColors.staticCircleLayerColorOn.cgColor
			staticCircleLayer.lineWidth = lineWidth
			label.applyGradientWith(startColor: PSColors.textColorFrom, endColor: PSColors.textColorTo)
		}
		
		let progress: CABasicAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
		
		progress.duration = duration
		progress.fromValue = circleLayerGradientMask.strokeStart
		progress.toValue = endValue
		progress.fillMode = CAMediaTimingFillMode.forwards
		progress.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeOut)
		progress.isRemovedOnCompletion = false
		circleLayerGradientMask.add(progress, forKey: "strokeEnd")
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
		
		let radius = circleView.bounds.width / 2 // for full cricle
		let circlePath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
		
		staticCircleLayer.path = circlePath.cgPath
		staticCircleLayer.position = circleView.center
		circleView.layer.addSublayer(staticCircleLayer)
		
		circleLayerGradientMask.path = circlePath.cgPath
		circleLayerGradientMask.lineCap = CAShapeLayerLineCap.round
		circleLayerGradientMask.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
		circleLayerGradientMask.position = circleView.center
		circleView.layer.addSublayer(circleLayerGradientMask)
	}
	
}

extension UILabel {
	func applyGradientWith(startColor: UIColor, endColor: UIColor) {
		let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
		
		// Create a gradient layer
		let gradient = CAGradientLayer()
		
		// gradient colors in order which they will visually appear
		gradient.colors = [startColor, endColor]
		
		// Gradient from left to right
		gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
		gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
		
		// set the gradient layer to the same size as the view
		gradient.frame = view.bounds
		// add the gradient layer to the views layer for rendering
		view.layer.addSublayer(gradient)
		
		view.mask = self
	}
	
}
