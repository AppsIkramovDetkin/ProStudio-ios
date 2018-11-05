//
//  SecurityScreen.swift
//  ProStudio
//
//  Created by Zimma on 28/10/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit

struct PSColors {
	static let blue = UIColor(displayP3Red: 0/255, green: 129/255, blue: 204/255, alpha: 1.0)
	static let buttonText = UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 1.0)
	static let light = UIColor(displayP3Red: 213/255, green: 213/255, blue: 213/255, alpha: 1.0)
	static let staticCircleLayerColorOn = UIColor(displayP3Red: 217/255, green: 229/255, blue: 239/255, alpha: 1.0)
	static let staticCircleLayerColorOff = UIColor(displayP3Red: 237/255, green: 239/255, blue: 242/255, alpha: 1.0)
	static let circleLayerGradientMask = UIColor(displayP3Red: 46/255, green: 107/255, blue: 176/255, alpha: 1.0)
	static let circleLayerGradientMaskShadow = UIColor(displayP3Red: 61/255, green: 137/255, blue: 184/255, alpha: 1.0)
	static let textColorOff = UIColor(displayP3Red: 237/255, green: 239/255, blue: 242/255, alpha: 1.0)
	static let textColorFrom = UIColor(displayP3Red: 44/255, green: 103/255, blue: 169/255, alpha: 1.0)
	static let textColorTo = UIColor(displayP3Red: 96/255, green: 176/255, blue: 191/255, alpha: 1.0)
	static let securityScreenBg = UIColor(displayP3Red: 13/255, green: 28/255, blue: 44/255, alpha: 1.0)
	static let securityScreenText = UIColor(displayP3Red: 0/255, green: 129/255, blue: 204/255, alpha: 1.0)
	static let securityScreenButton = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
	static let securityPointOff = UIColor(displayP3Red: 54/255, green: 54/255, blue: 54/255, alpha: 1.0)
	static let securityPointOn = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
	static let cancelButtonText = UIColor(displayP3Red: 255/255, green: 37/255, blue: 37/255, alpha: 1.0)
}

class SecurityScreen: UIViewController {
	
	override var preferredStatusBarStyle : UIStatusBarStyle {
		return .lightContent
	}
	
	let cancelButton: UIButton = {
		let button = UIButton()
		button.setTitle("Отмена", for: .normal)
		button.setTitleColor(PSColors.cancelButtonText, for: .normal)
		button.setTitleColor(PSColors.securityPointOff, for: .highlighted)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	//CodeView
	let codeView: UIView = {
		let view = UIView()
		view.backgroundColor = .clear
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let firstCodeLabel: UILabel = {
		let label = UILabel()
		label.textColor = PSColors.securityScreenText
		label.font = PSFonts.securityCodeLabel
		label.text = "Задайте код доступа"
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let firstCodeStackView = SecurityPoints()
	
	let secondCodeLabel: UILabel = {
		let label = UILabel()
		label.textColor = PSColors.securityScreenText
		label.font = PSFonts.securityCodeLabel
		label.text = "Повторите код доступа"
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let secondCodeStackView = SecurityPoints()
	
	//KeyBoardView
	let keyboardView = KeyboardView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.hero.isEnabled = true
		view.backgroundColor = PSColors.securityScreenBg
		
		setupView()
		setupCodeView()
		
		keyboardView.addObserver(self, forKeyPath: "numPass", options: [.new, .old], context: nil)
		keyboardView.addObserver(self, forKeyPath: "numPassCheck", options: [.new, .old], context: nil)
	}
	
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		
		let newValue = change?[.newKey] as? String
		let oldValue = change?[.oldKey] as? String
		
		switch keyPath {
		case "numPass":
			if newValue!.count > oldValue!.count {
				firstCodeStackView.pointArray[newValue!.count - 1].animate(on: true)
			} else if newValue!.count < oldValue!.count && oldValue!.count != 0 {
				firstCodeStackView.pointArray[oldValue!.count - 1].animate(on: false)
			}
		case "numPassCheck":
			if newValue!.count > oldValue!.count {
				secondCodeStackView.pointArray[newValue!.count - 1].animate(on: true)
			} else if newValue!.count < oldValue!.count && oldValue!.count != 0 {
				secondCodeStackView.pointArray[oldValue!.count - 1].animate(on: false)
			}
		default:
			break
		}
		
		if (keyboardView.numPassCheck.count + keyboardView.numPass.count) == 8 {
			let tabBarController = UITabBarController()
			
			//1.
			let listVC = ProjectsList()
			listVC.tabBarItem = UITabBarItem(title: "Проекты", image: nil, tag: 0)
			tabBarController.setViewControllers([listVC], animated: true)
			present(tabBarController, animated: true, completion: nil)
		}
	}
	
	private func setupCodeView() {
		codeView.addSubview(firstCodeLabel)
		codeView.addSubview(firstCodeStackView)
		codeView.addSubview(secondCodeLabel)
		codeView.addSubview(secondCodeStackView)
		
		let codeViews = ["firstCodeLabel": firstCodeLabel, "firstCodeStackView": firstCodeStackView, "secondCodeLabel": secondCodeLabel, "secondCodeStackView": secondCodeStackView]
		
		codeView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[firstCodeLabel]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: codeViews))
		codeView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[firstCodeStackView]-20-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: codeViews))
		codeView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[secondCodeLabel]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: codeViews))
		codeView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[secondCodeStackView]-20-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: codeViews))
		
		codeView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[firstCodeLabel(15)]-12-[firstCodeStackView(15)]-30-[secondCodeLabel(15)]-12-[secondCodeStackView(15)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: codeViews))
	}
	
	private func setupView() {
		
		view.addSubview(cancelButton)
		view.addSubview(codeView)
		view.addSubview(keyboardView)
		
		let views = ["cancelButton": cancelButton, "codeView": codeView, "keyboardView": keyboardView]
		
		let width = view.frame.width / 2
		
		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[cancelButton(100)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(width / 2)-[codeView(\(width))]-\(width / 2)-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[keyboardView]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
		
		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-40-[cancelButton(40)]-120-[codeView(\(width / 1.5))]-100-[keyboardView]-60-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
		
		cancelButton.addTarget(self, action: #selector(tappidButton), for: .touchUpInside)
		
	}
	
	@objc func tappidButton() {
		smartBack()
	}
	
}