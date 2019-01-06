import UIKit
import ImagePicker
import AlamofireImage

class ChatWithManager: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
	
	private let imageChatCellLeft   = "ImageChatCellLeft"
	private let imageChatCellRight  = "ImageChatCellRight"
	private let textChatCellLeft    = "TextChatCellLeft"
	private let textChatCellRight   = "TextChatCellRight"
    var messages: [MessageModel] = [] {
        didSet {
            tableView.reloadData()
            tableView.scrollToRow(at: IndexPath.init(row: tableView.numberOfRows(inSection: 0) - 1, section: 0), at: UITableView.ScrollPosition.bottom, animated: false)
        }
    }
	
	var userId: String?
	override func viewDidLoad() {
		super.viewDidLoad()
		registerCells()
		NavigationBarDecorator.decorate(self)
		navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        self.tableView.contentInsetAdjustmentBehavior = .never
		navigationItem.title = "Чат с менеджером"
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 140
        tableView.showsVerticalScrollIndicator = false
		textField.layer.borderColor = PSColor.silver.cgColor
		textField.layer.borderWidth = 0.8
        textField.autocapitalizationType = .sentences
		ProjectManager.shared.observeMessages(userId: userId) { (messages) in
            self.messages = messages
        }
	}
    
    @IBAction func attachButtonClicked(sender: UIButton) {
        let imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 1
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func sendButtonClicked(sender: UIButton) {
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        
        ProjectManager.shared.sendMessage(with: text, userId: userId)
        textField.text = nil
    }
	
	func textViewDidChange(_ textView: UITextView) {
		let newSize = textView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
		textView.frame = CGRect(origin: textView.frame.origin, size: newSize)
	}
	
}

extension ChatWithManager: ImagePickerDelegate {
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.dismiss(animated: true, completion: nil)
        guard let image = images.first else {
            return
        }
        
        ProjectManager.shared.uploadImage(image: image) { (id) in
					ProjectManager.shared.sendMessage(with: "hash)))image:\(id)", userId: self.userId)
        }
    }
}

extension ChatWithManager: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return messages.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let data = messages[indexPath.row]
		
        if data.textMessage.contains("hash)))image") {
            let id = String(data.textMessage.split(separator: ":")[1])
            let cell = tableView.dequeueReusableCell(withIdentifier: data.sender == "admin@admin.admin" ? imageChatCellRight : imageChatCellLeft, for: indexPath) as! ImageChatCell
            
            if let image = ProjectManager.shared.images[id] {
                cell.imageViewInMessage?.image = image
            } else {
                ProjectManager.shared.downloadImage(id: id) { (url) in
                    if cell.imageViewInMessage?.image == nil {
                        if let url = url {
                            cell.imageViewInMessage?.af_setImage(withURL: url, completion: { (response) in
                                if let image = cell.imageViewInMessage?.image {
                                    ProjectManager.shared.images[id] = image
                                }
                            })
                        }
                    }
                }
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: data.sender != currentUser.email ? textChatCellRight : textChatCellLeft, for: indexPath) as! TextChatCell
            cell.configure(by: data)
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
