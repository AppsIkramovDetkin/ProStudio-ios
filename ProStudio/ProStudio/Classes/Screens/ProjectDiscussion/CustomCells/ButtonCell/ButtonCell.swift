//
//  ButtonCell.swift
//  ProStudio
//
//  Created by Zimma on 10/10/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit

class ButtonCell: UITableViewCell {

    @IBOutlet weak var button: PSButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func send(_ sender: Any) {
        
        button.touched = {
            print("Ghbdtn")
        }
        
    }
    
}
