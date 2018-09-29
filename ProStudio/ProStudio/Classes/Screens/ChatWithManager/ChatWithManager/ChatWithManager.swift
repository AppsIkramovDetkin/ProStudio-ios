import UIKit

class ChatWithManager: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cellWithImageLeft       = "CellWithImageLeft"
    let cellWithImageRight      = "CellWithImageRight"
    let cellWithoutImageLeft    = "CellWithoutImageLeft"
    let cellWithoutImageRight   = "CellWithoutImageRight"
    
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
        let count = ChatModel.arrayForSample.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = ChatModel.arrayForSample[indexPath.row]
        
        if ChatModel.arrayForSample[indexPath.row].sender == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellWithoutImageLeft, for: indexPath) as? CellWithoutImage
            cell?.avatarImage.image = data.image
            cell?.textView.text = data.textMessage

            return cell!
        } else if ChatModel.arrayForSample[indexPath.row].sender == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellWithoutImageRight, for: indexPath) as? CellWithoutImage
            cell?.avatarImage.image = data.image
            cell?.textView.text = data.textMessage
            
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellWithoutImageLeft, for: indexPath) as? CellWithoutImage
            cell?.avatarImage.image = data.image
            cell?.textView.text = data.textMessage
            
            return cell!
        }
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: cellWithoutImageLeft, bundle: nil), forCellReuseIdentifier: cellWithoutImageLeft)
        tableView.register(UINib(nibName: cellWithoutImageRight, bundle: nil), forCellReuseIdentifier: cellWithoutImageRight)
        tableView.register(UINib(nibName: cellWithImageLeft, bundle: nil), forCellReuseIdentifier: cellWithImageLeft)
        tableView.register(UINib(nibName: cellWithImageRight, bundle: nil), forCellReuseIdentifier: cellWithImageRight)
    }
}
