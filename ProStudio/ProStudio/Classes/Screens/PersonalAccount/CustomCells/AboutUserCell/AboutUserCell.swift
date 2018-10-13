import UIKit

class AboutUserCell: UITableViewCell {
	
	@IBOutlet weak var abtUserLbl: UILabel!
	@IBOutlet weak var abtUserTextFld: UITextField!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	
	func nameSettings() {
		
		abtUserLbl.text = "Имя"
		abtUserLbl.textAlignment = .left
		abtUserLbl.textColor = CustomColors.textColor
		abtUserLbl.font = CustomFonts.cellText
		
		abtUserTextFld.placeholder = "Введите имя..."
		abtUserTextFld.text = "Филиппов Михаил"
		abtUserTextFld.font = CustomFonts.textFieldFont
		abtUserTextFld.textColor = CustomColors.cerulean
	}
	
	func numberSettings() {
		
		abtUserLbl.text = "Телефон"
		abtUserLbl.textAlignment = .left
		abtUserLbl.textColor = CustomColors.textColor
		abtUserLbl.font = CustomFonts.cellText
		
		abtUserTextFld.placeholder = "Введите номер..."
		abtUserTextFld.keyboardType = .numberPad
		abtUserTextFld.text = "+7 (981) 750-70-70"
		abtUserTextFld.textContentType = UITextContentType.telephoneNumber
		abtUserTextFld.font = CustomFonts.textFieldFont
		abtUserTextFld.textColor = CustomColors.cerulean
	}
	
	func mailSettings() {
		
		abtUserLbl.text = "Почта"
		abtUserLbl.textAlignment = .left
		abtUserLbl.textColor = CustomColors.textColor
		abtUserLbl.font = CustomFonts.cellText
		
		abtUserTextFld.placeholder = "Введите почту..."
		abtUserTextFld.text = "mail@prostudio.ru"
		abtUserTextFld.textContentType = UITextContentType.emailAddress
		abtUserTextFld.font = CustomFonts.textFieldFont
		abtUserTextFld.textColor = CustomColors.cerulean
	}
	
}


