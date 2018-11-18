import UIKit
import Shift

class ProjectTaskCell: UITableViewCell {
	
	@IBOutlet weak var taskButton: PSScaleView!
	@IBOutlet weak var taskTitle: ShiftMaskableLabel!
	@IBOutlet weak var taskComment: ShiftMaskableLabel!
	@IBOutlet weak var okImage: UIImageView!
	
	var colorsForGradient: [UIColor] = []
	
	override func awakeFromNib() {
		super.awakeFromNib()
		taskTitle.textLabel.font = PSFont.introBold.with(size: 17.0)
		taskComment.textLabel.font = PSFont.introBold.with(size: 14.0)
		taskComment.backgroundColor = .clear
		taskTitle.backgroundColor = .clear
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	
		taskButton.layer.cornerRadius = 10
		taskButton.layer.masksToBounds = true
		
	}
	
	var layouted = false
	var done = false
	
	override func layoutSubviews() {
		super.layoutSubviews()
		guard !layouted && !done else {
			return
		}
		layouted = true
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0) {
			self.taskButton.layer.cornerRadius = 10
			self.taskButton.clipsToBounds = true
			
			let gradient = CAGradientLayer()
			gradient.frame =  CGRect(origin: CGPoint.zero, size: self.taskButton.frame.size)
			gradient.colors = [self.colorsForGradient[0].cgColor, self.colorsForGradient[1].cgColor]
			
			let shape = CAShapeLayer()
			shape.lineWidth = 3
			
			shape.path = UIBezierPath(roundedRect: self.taskButton.bounds, cornerRadius: self.taskButton.layer.cornerRadius).cgPath
			
			shape.strokeColor = UIColor.black.cgColor
			shape.fillColor = UIColor.clear.cgColor
			gradient.mask = shape
			
			self.taskButton.layer.addSublayer(gradient)
		}
		
	}
	
	func settingsCell(done: Bool) {
		self.done = done
		if done {
			
			let layer = CAGradientLayer()
			layer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: taskButton.frame.size.height)
			layer.startPoint = CGPoint(x: 0, y: 0.5)
			layer.endPoint = CGPoint(x: 1, y: 0.5)
			layer.colors = [colorsForGradient[0].cgColor, colorsForGradient[1].cgColor]
			taskButton.layer.insertSublayer(layer, at: 0)

			okImage.image = UIImage(named: "ok")
			taskTitle.setColors([UIColor.white, UIColor.white])
			taskTitle.start(shiftPoint: .left)
			taskTitle.end(shiftPoint: .right)
			taskTitle.animationDuration(3.0)
			taskTitle.maskToText = true
			taskTitle.startTimedAnimation()
			
			taskComment.setColors([.white, UIColor.white])
			taskComment.start(shiftPoint: .left)
			taskComment.end(shiftPoint: .right)
			taskComment.animationDuration(3.0)
			taskComment.maskToText = true
			taskComment.startTimedAnimation()
		} else {
			taskTitle.setColors(colorsForGradient)
			taskTitle.start(shiftPoint: .left)
			taskTitle.end(shiftPoint: .right)
			taskTitle.animationDuration(1.5)
			taskTitle.maskToText = true
			taskTitle.startTimedAnimation()
			
			
			taskComment.setColors(colorsForGradient)
			taskComment.start(shiftPoint: .left)
			taskComment.end(shiftPoint: .right)
			taskComment.animationDuration(1.5)
			taskComment.maskToText = true
			taskComment.startTimedAnimation()
			okImage.image = .none
		}
	}
}
