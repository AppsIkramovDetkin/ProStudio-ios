//
//  ChatTextField.swift
//  ProStudio
//
//  Created by Hadevs on 19/11/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit

class ChatTextField: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        return rect(for: bounds)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        return rect(for: bounds)
    }
    
    func rect(for bounds: CGRect) -> CGRect {
        let rect = CGRect(x: 16, y: 0, width: bounds.width - 16 - 16, height: bounds.height)
        return rect
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        return rect(for: bounds)
    }
}
