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
        
        setupButton()
        
    }
    
    private func setupButton() {
        
        layer.backgroundColor = GlobalColors.blue.cgColor
        titleLabel?.font = UIFont(name: "Intro-Bold", size: 17)
        setTitleColor(GlobalColors.buttonText, for: .normal)
        layer.cornerRadius = frame.height / 2
        layer.shadowColor = GlobalColors.blue.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.masksToBounds = false
        layer.shadowOpacity = 7
        layer.shadowRadius = 5
        
    }

}
