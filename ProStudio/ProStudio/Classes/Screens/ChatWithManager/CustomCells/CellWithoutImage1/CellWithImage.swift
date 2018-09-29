import UIKit

class CellWithImage: UITableViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var imageInMessage: UIImageView!
  
    override func awakeFromNib() {
        avatarImage.roundCornersAvatarImage()
        bubbleView.roundCornersBubleView()
    }
}
