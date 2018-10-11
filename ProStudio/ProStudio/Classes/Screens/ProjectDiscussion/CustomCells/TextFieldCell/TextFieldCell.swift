//
//  TextFieldCell.swift
//  ProStudio
//
//  Created by Zimma on 10/10/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit

class TextFieldCell: UITableViewCell {
    
    @IBOutlet weak var textField: CustomTextField!
    var whaaat = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textField.delegate = self
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        endEditing(true)
    }
    
    func start(what: Bool) {
        
        if what {
            if !textField.isActive {
                textField.chengeBorderColor()
            }
        } else {
            if textField.text == "" {
                textField.chengeBorderColor()
            }
        }
        
        
    }
    
}

extension TextFieldCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        start(what: true)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        start(what: false)
        
    }
}
