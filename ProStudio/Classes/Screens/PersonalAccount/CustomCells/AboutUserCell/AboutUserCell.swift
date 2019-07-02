import UIKit

class AboutUserCell: UITableViewCell {
	
	@IBOutlet weak var aboutUserLabel: UILabel!
	@IBOutlet weak var aboutUserTextField: UITextField!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	
	func nameSettings() {
		
		let line = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 0.33))
		line.backgroundColor = PSColor.grayLine
		self.addSubview(line)
		
		aboutUserLabel.text = "Имя"
		aboutUserLabel.textAlignment = .left
		aboutUserLabel.textColor = PSColor.textColor
		aboutUserLabel.font = PSFont.cellText
		
		aboutUserTextField.placeholder = "Введите имя..."
		aboutUserTextField.text = "Филиппов Михаил"
		aboutUserTextField.font = PSFont.introBook.with(size: 17)
		aboutUserTextField.textColor = PSColor.cerulean
		
	}
	
	func numberSettings() {
		
		aboutUserLabel.text = "Телефон"
		aboutUserLabel.textAlignment = .left
		aboutUserLabel.textColor = PSColor.textColor
		aboutUserLabel.font = PSFont.cellText
		
		aboutUserTextField.placeholder = "Введите номер..."
		aboutUserTextField.keyboardType = .numberPad
		aboutUserTextField.text = "+7 (981) 750-70-70"
		aboutUserTextField.textContentType = UITextContentType.telephoneNumber
		aboutUserTextField.font = PSFont.introBook.with(size: 17)
		aboutUserTextField.textColor = PSColor.cerulean
	}
	
	func mailSettings() {
		
		aboutUserLabel.text = "Почта"
		aboutUserLabel.textAlignment = .left
		aboutUserLabel.textColor = PSColor.textColor
		aboutUserLabel.font = PSFont.cellText
		
		aboutUserTextField.placeholder = "Введите почту..."
		aboutUserTextField.text = "mail@prostudio.ru"
		aboutUserTextField.textContentType = UITextContentType.emailAddress
		aboutUserTextField.font = PSFont.introBook.with(size: 17)
		aboutUserTextField.textColor = PSColor.cerulean
	}
	
}


