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
        
        styleTextField()
        
    }

    private func styleTextField() {
        
        borderStyle = .none
        layer.masksToBounds = true
        border.borderWidth = width1
        border.frame = CGRect(x: 0, y: frame.size.height - width1, width: frame.size.width, height: 3)
        border.borderColor = GlobalColors.light.cgColor
        layer.addSublayer(border)
        
        font = UIFont(name: "Intro-Book", size: 24)
        attributedPlaceholder = NSAttributedString(string: placeholderText ?? "", attributes: [.font: UIFont(name: "Intro-Book", size: 17) as Any])
        
    }
    
    func chengeBorderColor() {
        
        if isActive {
            
            border.borderColor = GlobalColors.light.cgColor
            
        } else {
            
            border.borderColor = GlobalColors.blue.cgColor
            
        }
        
        isActive = !isActive
        
    }
    
    func addRightButton() {
        
        let viewSize = frame.height
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: viewSize, height: viewSize))
        
        rightButton.frame.size = CGSize(width: view.frame.width, height: view.frame.height)
        rightButton.setImage(UIImage(named: "arrowDown"), for: .normal)
        rightButton.imageView?.contentMode = .scaleAspectFit
        rightButton.frame.size = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        
        view.addSubview(rightButton)
        
        rightView = view
        rightViewMode = .always
        
    }
    
}
