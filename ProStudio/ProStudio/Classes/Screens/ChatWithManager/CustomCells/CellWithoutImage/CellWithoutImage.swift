import UIKit

class CellWithoutImage: UITableViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        bubbleView.roundCornersBubleView()
        avatarImage.roundCornersAvatarImage()
    }
}
