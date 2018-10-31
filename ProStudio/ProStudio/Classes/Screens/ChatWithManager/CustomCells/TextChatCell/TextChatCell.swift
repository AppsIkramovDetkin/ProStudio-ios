import UIKit

class TextChatCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius  = 17.5
        avatarImageView.clipsToBounds       = true
        bubbleView.layer.cornerRadius       = 5.0
        bubbleView.clipsToBounds            = true
    }
}
