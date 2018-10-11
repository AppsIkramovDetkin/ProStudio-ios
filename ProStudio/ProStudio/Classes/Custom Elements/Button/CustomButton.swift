//
//  CustomButton.swift
//  ProStudio
//
//  Created by Zimma on 10/10/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        customizeButton()
    }
    
    private func customizeButton() {
        
        layer.backgroundColor = PSColors.blue.cgColor
        titleLabel?.font = UIFont(name: "Intro-Bold", size: 17)
        setTitleColor(PSColors.buttonText, for: .normal)
        layer.cornerRadius = frame.height / 2
        layer.shadowColor = PSColors.blue.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.masksToBounds = false
        layer.shadowOpacity = 7
        layer.shadowRadius = 5
        
    }
    
    func action(complition: ()->()) {
        complition()
    }

}
