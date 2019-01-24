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
		label.font = PSFont.introBold.with(size: 42)
		
		return label
	}()
	
	private lazy var circleView: UIView = {
		let circleView = UIView()
		circleView.translatesAutoresizingMaskIntoConstraints = false
		return circleView
	}()
	

	private let progressView: UIProgressView = {
		let progress = UIProgressView()
		return progress
	}()
	
	@IBInspectable var lineWidth: CGFloat = 25 {
		didSet {
			updateLineWidths()
		}
	}
	
	@IBInspectable var backLineWidth: CGFloat = 25 {
		didSet {
			updateLineWidths()
		}
	}
    
    var project: Project!
    
    convenience init(project: Project) {
        self.init()
        self.project = project
    }
    
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		addCircleView()
		addLabel()
	}
    let shape = CAShapeLayer()
	private func updateLineWidths() {
//        circleLayerGradientMask.lineWidth = lineWidth
        shape.lineWidth = lineWidth
	}
	
	func animate(with value: CGFloat, duration: TimeInterval = 2) {
		
		var endValue = value
		if endValue > 1 {
			endValue = 1
		}
		
		label.text = "\(Int(endValue * 100))%"
		if value > 0 {
            shape.strokeColor = PSColors.staticCircleLayerColorOn.cgColor
            shape.lineWidth = lineWidth
//            label.applyGradientWith(startColor: PSColors.textColorFrom, endColor: PSColors.textColorTo)
		}
		
		let progress: CABasicAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
		
		progress.duration = duration
		progress.fromValue = 0
		progress.toValue = endValue
		progress.fillMode = CAMediaTimingFillMode.forwards
		progress.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeOut)
		progress.isRemovedOnCompletion = false
		shape.add(progress, forKey: "strokeEnd")
	}
	
    
    var isLayouted = false
	override func layoutSubviews() {
		super.layoutSubviews()
		
        if !isLayouted {
            isLayouted = true
            addLayersForCircleView()
        }
		
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
        let scale: CGFloat = 0.9
        let delta = bounds.height - bounds.height * scale
        let ovalIn = CGRect(x: bounds.origin.x + delta / 2, y: bounds.origin.y + delta / 2, width: bounds.width * scale, height: bounds.height * scale)
        let path = UIBezierPath(arcCenter: CGPoint.init(x: bounds.width / 2, y: bounds.height / 2), radius: bounds.width / 2 - backLineWidth/2, startAngle: CGFloat(Double.pi / 2 * -1), endAngle: CGFloat(Double.pi / 2 * -1 + Double.pi * 2), clockwise: true)
        
        shape.fillColor = UIColor.clear.cgColor
        shape.lineWidth = backLineWidth
        shape.lineCap = .round
        shape.strokeStart = 0
        shape.strokeEnd = 1
        shape.path = path.cgPath
        shape.position = circleView.center
        let staticShape = CAShapeLayer()
        staticShape.fillColor = UIColor.clear.cgColor
        staticShape.strokeColor = project.gradientsColor[1].withAlphaComponent(0.1).cgColor
        staticShape.lineWidth = backLineWidth
        staticShape.lineCap = .round
        staticShape.path = path.cgPath
        staticShape.position = circleView.center
        layer.addSublayer(staticShape)
        
        layer.addSublayer(shape)
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = project.gradientsColor.map{$0.cgColor}
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.mask = shape
        
        layer.addSublayer(gradient)
	}
	
}
