import UIKit

class TextChatCell: UITableViewCell {
	
	@IBOutlet weak var avatarImageView: UIImageView!
	@IBOutlet weak var bubbleView: UIView!
	@IBOutlet weak var textView: UITextView!
	@IBOutlet weak var timeLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		textView.font = PSFont.introBook.with(size: 17)
		textView.textContainerInset = .zero
		timeLabel.font = PSFont.introBook.with(size: 12)
		bubbleView.layer.cornerRadius       = 8
		avatarImageView.clipsToBounds       = true
		bubbleView.clipsToBounds            = true
	}
    
	func configure(by message: MessageModel) {
			textView.text = message.textMessage
			let time = message.time ?? 0
			let date = Date(timeIntervalSince1970: time)
			timeLabel.text = date.convertFormateToNormDateString(format: "HH:mm")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
	}
}
