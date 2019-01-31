import UIKit

class TextChatCell: UITableViewCell {
	
	@IBOutlet weak var avatarImageView: UIImageView!
	@IBOutlet weak var bubbleView: UIView!
	@IBOutlet weak var textView: UITextView!
	@IBOutlet weak var timeLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
//		textView.font = PSFont.introBook.with(size: 17)
		textView.textContainerInset = .zero
		timeLabel.font = PSFont.introBook.with(size: 12)
		bubbleView.layer.cornerRadius       = 10
		avatarImageView.clipsToBounds       = true
		bubbleView.clipsToBounds            = true
	}
    
	func configure(by message: MessageModel) {
//		textView.text = message.textMessage
		configureTextView(with: message.textMessage)
		let time = message.time ?? 0
		let date = Date(timeIntervalSince1970: time)
		timeLabel.text = date.convertFormateToNormDateString(format: "HH:mm")
	}
	
	private func configureTextView(with string: String) {
		let aStr = NSMutableAttributedString(string: string)
		let range = NSRange(location: 0, length: aStr.length)
		
		let style = NSMutableParagraphStyle()
		style.lineSpacing = 3
		aStr.addAttribute(.paragraphStyle, value: style, range: range)
		aStr.addAttribute(.font, value: PSFont.introBook.with(size: 17), range: range)
		textView.attributedText = aStr
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
	}
}
