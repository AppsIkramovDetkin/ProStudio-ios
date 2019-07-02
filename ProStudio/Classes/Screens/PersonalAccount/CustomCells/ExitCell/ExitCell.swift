import UIKit

class ExitCell: UITableViewCell {
	
	@IBOutlet weak var exitButton: UIButton!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		exitButtonSettings()
	}
	
	private func exitButtonSettings() {
		exitButton.setTitle("Выйти из аккаунта", for: .normal)
		exitButton.titleLabel?.font = PSFont.introBook.with(size: 17)
		exitButton.setTitleColor(PSColor.customRed, for: .normal)
		exitButton.isUserInteractionEnabled = false
//		exitButton.titleLabel?.font = PSFont.exitButtonFont
	}
	
}

