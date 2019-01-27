//
//  standartTextFieldCell.swift
//  ProStudio
//
//  Created by Ruslan Prozhivin on 21/01/2019.
//  Copyright © 2019 Nikita. All rights reserved.
//

import UIKit

class StandartTextFieldCell: UITableViewCell {
	@IBOutlet weak var textField: UITextField!
	
	var textChanged: ItemClosure<String>?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		textField.addTarget(self, action: #selector(textaction), for: .editingChanged)
	}
	
	@objc private func textaction() {
		textChanged?(textField.text ?? "")
	}
}
