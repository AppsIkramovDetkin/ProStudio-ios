import UIKit

class ChatWithManager: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let imageChatCellLeft   = "ImageChatCellLeft"
    private let imageChatCellRight  = "ImageChatCellRight"
    private let textChatCellLeft    = "TextChatCellLeft"
    private let textChatCellRight   = "TextChatCellRight"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let newSize = textView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        textView.frame = CGRect(origin: textView.frame.origin, size: newSize)
    }
    
}

extension ChatWithManager: UITableViewDataSource, UITableViewDelegate {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = MessageModel.mockedMessages.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = MessageModel.mockedMessages[indexPath.row]
        
        
        if MessageModel.mockedMessages[indexPath.row].sender != true {
            let cell = tableView.dequeueReusableCell(withIdentifier: textChatCellRight, for: indexPath) as! TextChatCell
            cell.avatarImageView.image = data.image
            cell.textView.text = data.textMessage
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: textChatCellLeft, for: indexPath) as! TextChatCell
            cell.avatarImageView.image = data.image
            cell.textView.text = data.textMessage
            
            return cell
        }
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: textChatCellLeft, bundle: nil), forCellReuseIdentifier: textChatCellLeft)
        tableView.register(UINib(nibName: textChatCellRight, bundle: nil), forCellReuseIdentifier: textChatCellRight)
        tableView.register(UINib(nibName: imageChatCellLeft, bundle: nil), forCellReuseIdentifier: imageChatCellLeft)
        tableView.register(UINib(nibName: imageChatCellRight, bundle: nil), forCellReuseIdentifier: imageChatCellRight)
    }
}
