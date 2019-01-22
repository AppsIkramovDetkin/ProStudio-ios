//
//  HeaderView.swift
//  ProStudio
//
//  Created by Вал on 14/10/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {
	@IBOutlet weak var avatar: UIImageView!
	@IBOutlet weak var userName: UILabel!
	@IBOutlet weak var companyName: UILabel!
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		avatar.image = UIImage(named: "ava")
		avatar.layer.cornerRadius = avatar.frame.size.width / 2
		avatar.clipsToBounds = true
		
		userName.font = PSFont.introBold.with(size: 22)
		userName.textColor = UIColor.black
		
		companyName.text = "Цифровая Империя"
		companyName.textColor = PSColor.companyNameColor
		companyName.font = PSFont.introBook.with(size: 17)
		
	}
	


}
