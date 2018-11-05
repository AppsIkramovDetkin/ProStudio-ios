//
//  HeaderView.swift
//  ProStudio
//
//  Created by Вал on 14/10/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {

	@IBOutlet weak var ceruleanHeader: UIView!
	@IBOutlet weak var personalAccount: UILabel!
	@IBOutlet weak var avatar: UIImageView!
	@IBOutlet weak var avatarBorder: UIView!
	@IBOutlet weak var backgroundPhoto: UIImageView!
	@IBOutlet weak var userName: UILabel!
	@IBOutlet weak var companyName: UILabel!
	
	override func draw(_ rect: CGRect) {
		
		ceruleanHeader.backgroundColor = PSColor.cerulean
		backgroundPhoto.image = UIImage(named: "ava")?.alpha(0.5)
		backgroundPhoto.contentMode = .scaleAspectFill
		let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
		visualEffectView.frame = backgroundPhoto.bounds
		visualEffectView.alpha = 0.5
		visualEffectView.backgroundColor = PSColor.cerulean
		backgroundPhoto.addSubview(visualEffectView)
		
		avatarBorder.layer.cornerRadius = avatarBorder.frame.size.width / 2
		avatarBorder.layer.borderWidth = 11
		avatarBorder.layer.borderColor = UIColor.white.cgColor
		avatarBorder.clipsToBounds = true
		
		avatar.image = UIImage(named: "ava")
		avatar.layer.cornerRadius = avatar.frame.size.width / 2
		avatar.clipsToBounds = true
		
		personalAccount.text = "Личный кабинет"
		personalAccount.font = PSFont.headerText
		personalAccount.textColor = UIColor.white
		
		userName.text = "Филиппов Михаил"
		userName.font = PSFont.nameFont
		userName.textColor = UIColor.black
		
		companyName.text = "Цифровая Империя"
		companyName.textColor = PSColor.companyNameColor
		companyName.font = PSFont.companyFont
		
	}


}
