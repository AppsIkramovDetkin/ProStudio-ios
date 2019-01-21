//
//  LabelWithCheckMarkCell.swift
//  ProStudio
//
//  Created by Ruslan Prozhivin on 21/01/2019.
//  Copyright © 2019 Nikita. All rights reserved.
//

import UIKit

class LabelWithCheckMarkCell: UITableViewCell {
	@IBOutlet weak var label: UILabel!
	@IBOutlet weak var checkMarkImageView: UIImageView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		label.font = UIFont(name: "SF Pro Text-Regular", size: 14)
		checkMarkImageView.isHidden = true
	}
}
