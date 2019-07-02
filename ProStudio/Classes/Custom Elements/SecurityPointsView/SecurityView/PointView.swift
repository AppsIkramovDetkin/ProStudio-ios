//
//  Point.swift
//  ProStudio
//
//  Created by Zimma on 29/10/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit

class PointView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        customizePointView()
    }
    
    private func customizePointView() {
        layer.backgroundColor = PSColors.securityPointOff.cgColor
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = false
    }
    
    func animate(on: Bool) {
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseInOut, animations: {
            self.layer.backgroundColor = on ? PSColors.securityPointOn.cgColor : PSColors.securityPointOff.cgColor
            self.layer.shadowColor = on ? PSColors.securityPointOn.cgColor : PSColors.securityPointOff.cgColor
            self.layer.shadowOpacity = on ? 7 : 0
            self.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.layer.shadowRadius = on ? 5 : 0
        })
    }
}
