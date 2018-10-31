//
//  PSCircularVIew.swift
//  circular-view
//
//  Created by Danil Detkin on 07/07/2018.
//  Copyright © 2018 DL. All rights reserved.
//

import UIKit

struct PSColors {
    static let staticCircleLayerColorOn = UIColor(displayP3Red: 217/255, green: 229/255, blue: 239/255, alpha: 1.0)
    static let staticCircleLayerColorOff = UIColor(displayP3Red: 237/255, green: 239/255, blue: 242/255, alpha: 1.0)
    static let circleLayerGradientMask = UIColor(displayP3Red: 46/255, green: 107/255, blue: 176/255, alpha: 1.0)
    static let circleLayerGradientMaskShadow = UIColor(displayP3Red: 61/255, green: 137/255, blue: 184/255, alpha: 1.0)
    static let textColorOff = UIColor(displayP3Red: 237/255, green: 239/255, blue: 242/255, alpha: 1.0)
    static let textColorFrom = UIColor(displayP3Red: 44/255, green: 103/255, blue: 169/255, alpha: 1.0)
    static let textColorTo = UIColor(displayP3Red: 96/255, green: 176/255, blue: 191/255, alpha: 1.0)
}

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
	
//    var circleLayerGradientLayer: CAGradientLayer = {
//        let circleLayerGradientLayer = CAGradientLayer()
//        circleLayerGradientLayer.locations = [0.0, 1.0]
//        circleLayerGradientLayer.startPoint = CGPoint.init(x: 1, y: 0)
//        circleLayerGradientLayer.endPoint = CGPoint.init(x: 0, y: 1)
//        circleLayerGradientLayer.colors = [UIColor.red, UIColor.green]
//        circleLayerGradientLayer.masksToBounds = true
//        return circleLayerGradientLayer
//    }()
	
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
//        circleLayerGradientLayer.mask = circleLayerGradientMask
//        circleView.layer.addSublayer(circleLayerGradientLayer)
        circleView.layer.addSublayer(circleLayerGradientMask)
	}
    
}

extension UILabel {
    
    func applyGradientWith(startColor: UIColor, endColor: UIColor) -> Bool {
        
        var startColorRed:CGFloat = 0
        var startColorGreen:CGFloat = 0
        var startColorBlue:CGFloat = 0
        var startAlpha:CGFloat = 0
        
        if !startColor.getRed(&startColorRed, green: &startColorGreen, blue: &startColorBlue, alpha: &startAlpha) {
            return false
        }
        
        var endColorRed:CGFloat = 0
        var endColorGreen:CGFloat = 0
        var endColorBlue:CGFloat = 0
        var endAlpha:CGFloat = 0
        
        if !endColor.getRed(&endColorRed, green: &endColorGreen, blue: &endColorBlue, alpha: &endAlpha) {
            return false
        }
        
        let gradientText = self.text ?? ""
        
        let name:String = NSAttributedString.Key.font.rawValue
        let textSize: CGSize = gradientText.size(withAttributes: [NSAttributedString.Key(rawValue: name):self.font])
        let width:CGFloat = textSize.width
        let height:CGFloat = textSize.height
        
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return false
        }
        
        UIGraphicsPushContext(context)
        
        let glossGradient:CGGradient?
        let rgbColorspace:CGColorSpace?
        let num_locations:size_t = 2
        let locations:[CGFloat] = [ 0.0, 1.0 ]
        let components:[CGFloat] = [startColorRed, startColorGreen, startColorBlue, startAlpha, endColorRed, endColorGreen, endColorBlue, endAlpha]
        rgbColorspace = CGColorSpaceCreateDeviceRGB()
        glossGradient = CGGradient(colorSpace: rgbColorspace!, colorComponents: components, locations: locations, count: num_locations)
        let topCenter = CGPoint.zero
        let bottomCenter = CGPoint(x: textSize.width, y: 0)
        
        context.drawLinearGradient(glossGradient!, start: topCenter, end: bottomCenter, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
        
        UIGraphicsPopContext()
        
        guard let gradientImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return false
        }
        
        UIGraphicsEndImageContext()
        
        self.textColor = UIColor(patternImage: gradientImage)
        
        return true
    }
    
}
