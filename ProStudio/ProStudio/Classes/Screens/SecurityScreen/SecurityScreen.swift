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
	static let separatorColor = #colorLiteral(red: 0.9214485884, green: 0.9216245413, blue: 0.9295840859, alpha: 1)
}

class SecurityScreen: UIViewController {
	
	override var preferredStatusBarStyle : UIStatusBarStyle {
		return .lightContent
	}
	
	let cancelButton: UIButton = {
		let button = UIButton()
		button.setTitle("Отмена", for: .normal)
        button.titleLabel?.font = PSFont.introBook.with(size: 15)
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
	var isRegister = true
	override func viewDidLoad() {
		super.viewDidLoad()
		self.hero.isEnabled = true
		view.backgroundColor = PSColors.securityScreenBg
		
		setupView()
		setupCodeView()
        if !isRegister {
            secondCodeStackView.isHidden = true
            secondCodeLabel.isHidden = true
        }
		keyboardView.addObserver(self, forKeyPath: "numPass", options: [.new, .old], context: nil)
		keyboardView.addObserver(self, forKeyPath: "numPassCheck", options: [.new, .old], context: nil)
		if needToUserBiometric {
			LAInteractor.shared.request { (bb) in
				if bb {
					self.openMain()
				}
			}
		}
		
	}
	func openMain() {
		
		let tabBarController = UITabBarController()
		
		//1.
		let listVC = UINavigationController.init(rootViewController: ProgressListViewController())
		listVC.tabBarItem = UITabBarItem(title: "Проекты", image: UIImage.init(named: "projects"), tag: 0)
		//2.
		let cabinetVC = PersonalAccount()
		let cabinetItem = UITabBarItem(title: "Личный кабинет", image: UIImage.init(named: "profile"), tag: 1)
		let inset3: CGFloat = 0
		cabinetItem.imageInsets = UIEdgeInsets(top: inset3, left: inset3, bottom: inset3, right: inset3)
		cabinetVC.tabBarItem = cabinetItem
		
		//3.
		let chatVC = UINavigationController(rootViewController: ChatWithManager())
		let chatItem = UITabBarItem(title: "Поддержка", image: UIImage.init(named: "support"), tag: 2)
		chatItem.imageInsets = UIEdgeInsets(top: inset3, left: inset3, bottom: inset3, right: inset3)
		chatVC.tabBarItem = chatItem
		//4.
		let contactsVC = UINavigationController(rootViewController: ContactsViewController())
		let contactsTabItem = UITabBarItem(title: "Контакты", image: UIImage.init(named: "contacts"), tag: 0)
		let inset2: CGFloat = 0
		contactsTabItem.imageInsets = UIEdgeInsets(top: inset2, left: inset2, bottom: inset2, right: inset2)
		
		contactsVC.tabBarItem = contactsTabItem
		
		tabBarController.tabBar.tintColor = PSColor.cerulean
		tabBarController.tabBar.unselectedItemTintColor = PSColor.coolGrey
		tabBarController.setViewControllers([listVC, chatVC, cabinetVC, contactsVC], animated: true)
		self.present(tabBarController, animated: true, completion: nil)
	}
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		
        func openNeededScreen() {
					if LAInteractor.shared.biometricType == .none {
						openMain()
					} else {
						let mom = BiomerticViewController()
						let touch = UINavigationController.init(rootViewController: mom)
						mom.closed = {
							self.openMain()
						}
						present(touch, animated: true, completion: nil)
					}
					
					
        }
        if isRegister {
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
            
            
            if (keyboardView.numPassCheck.count + keyboardView.numPass.count) == 8 && keyboardView.numPassCheck == keyboardView.numPass {
                defaults.set(keyboardView.numPass, forKey: "pin")
                defaults.synchronize()
                
                openNeededScreen()
            }
        } else {
            // login
            let newValue = change?[.newKey] as? String
            let oldValue = change?[.oldKey] as? String
            
            switch keyPath {
            case "numPass":
                if newValue!.count > oldValue!.count {
                    firstCodeStackView.pointArray[newValue!.count - 1].animate(on: true)
                } else if newValue!.count < oldValue!.count && oldValue!.count != 0 {
                    firstCodeStackView.pointArray[oldValue!.count - 1].animate(on: false)
                }
            default:
                break
            }
            
            if keyboardView.numPass.count == 4 {
                // try to login
                let enteredPin = keyboardView.numPass
                let pin = defaults.string(forKey: "pin") ?? ""
                if enteredPin == pin {
                    openNeededScreen()
                } else {
                    self.firstCodeStackView.pointArray.forEach{$0.animate(on: false)}
                    keyboardView.numPass = ""
                    self.showAlert(title: "Ошибка", message: "Вы ввели неверный PIN.")
                }
            }
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
