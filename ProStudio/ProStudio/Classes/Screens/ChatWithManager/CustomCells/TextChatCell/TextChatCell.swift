import UIKit

class TextChatCell: UITableViewCell {
	
	@IBOutlet weak var avatarImageView: UIImageView!
	@IBOutlet weak var bubbleView: UIView!
	@IBOutlet weak var textView: UITextView!
	@IBOutlet weak var timeLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		textView.font = PSFont.introBook.with(size: 12.5)
		timeLabel.font = PSFont.introBook.with(size: 12.5)
		avatarImageView.layer.cornerRadius  = 17.5
		avatarImageView.clipsToBounds       = true
		bubbleView.layer.cornerRadius       = 7
		bubbleView.clipsToBounds            = true
	}
    
    func configure(by message: MessageModel) {
        textView.text = message.textMessage
        let time = message.time ?? 0
        let date = Date(timeIntervalSince1970: time)
        timeLabel.text = date.convertFormateToNormDateString(format: "HH:mm")
    }
}
