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
		exitButton.setTitle("ВЫЙТИ", for: .normal)
		exitButton.setTitleColor(CustomColors.customRed, for: .normal)
		exitButton.titleLabel?.font = CustomFonts.exitButtonFont
	}
	
}

