import UIKit

class ProjectTaskCell: UITableViewCell {
	
	@IBOutlet weak var taskButton: UIButton!
	@IBOutlet weak var taskTitle: UILabel!
	@IBOutlet weak var taskComment: UILabel!
	@IBOutlet weak var okImage: UIImageView!
	
	let colorsForGradient = [PSColor.cerulean.cgColor, UIColor.white.cgColor, UIColor.red.cgColor, UIColor.purple.cgColor, UIColor.yellow.cgColor, UIColor.orange.cgColor, UIColor.green.cgColor, UIColor.gray.cgColor, UIColor.lightGray.cgColor]
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		taskButton.addTarget(self, action: #selector(doneButton(_:)), for: .touchUpInside)
		taskButton.layer.cornerRadius = 10
		taskButton.layer.masksToBounds = true
		
	}
	
	func settingsCell(done: Bool) {
		
		if done {
			
			let layer = CAGradientLayer()
			layer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: taskButton.frame.size.height)
			layer.startPoint = CGPoint(x: 0, y: 0.5)
			layer.endPoint = CGPoint(x: 1, y: 0.5)
			layer.colors = [colorsForGradient[Int.random(in: 0...5)], colorsForGradient[Int.random(in: 0...5)]]
			taskButton.layer.addSublayer(layer)

			okImage.image = UIImage(named: "ok")
			taskTitle.textColor = UIColor.white
			taskComment.textColor = UIColor.white
			
		} else {
			
			taskTitle.textColor = PSColor.cerulean
			taskComment.textColor = PSColor.cerulean
			
			taskButton.layer.borderWidth = 2
			taskButton.layer.borderColor = PSColor.cerulean.cgColor
			taskButton.layer.cornerRadius = 10
			taskButton.layer.masksToBounds = true
			okImage.image = .none
			
		}
	}
	
	@objc func doneButton(_ sender: UIButton) {
		print("now true")
	}
	
}

