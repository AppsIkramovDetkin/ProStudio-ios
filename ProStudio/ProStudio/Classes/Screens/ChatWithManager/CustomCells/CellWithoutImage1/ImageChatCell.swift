import UIKit

class ImageChatCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var imageViewInMessage: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius  = 17.5
        avatarImageView.clipsToBounds       = true
        bubbleView.layer.cornerRadius       = 5.0
        bubbleView.clipsToBounds            = true
        imageViewInMessage.image = nil
        imageViewInMessage.contentMode = .scaleAspectFill
        imageViewInMessage.backgroundColor = PSColor.coolGrey
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageViewInMessage.image = nil
    }
}
