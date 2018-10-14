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
		notificationLabel.textColor = PSColor.textColor
		notificationLabel.font = PSFont.cellText
		
		switchControl.tintColor = PSColor.cerulean
		switchControl.onTintColor = PSColor.cerulean
	}
	
}

