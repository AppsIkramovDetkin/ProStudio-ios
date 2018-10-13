import UIKit

class NotificationCell: UITableViewCell {
	
	@IBOutlet weak var notificationLabel: UILabel!
	@IBOutlet weak var switchControl: UISwitch!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		notificationSettings()
	}
	
	private func notificationSettings() {
		notificationLabel.text = "PUSH уведомления"
		notificationLabel.textAlignment = .left
		notificationLabel.textColor = CustomColors.textColor
		notificationLabel.font = CustomFonts.cellText
		
		switchControl.tintColor = CustomColors.cerulean
		switchControl.onTintColor = CustomColors.cerulean
	}
	
}

