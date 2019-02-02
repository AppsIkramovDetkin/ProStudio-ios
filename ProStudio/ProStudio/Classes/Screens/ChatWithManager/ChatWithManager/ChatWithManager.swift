import UIKit
import ImagePicker
import AlamofireImage
import IQKeyboardManagerSwift

class ChatWithManager: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var textField: ChatTextField!
	@IBOutlet weak var sendButton: UIButton!
//	@IBOutlet weak var chatHeight: NSLayoutConstraint!
	
	@IBOutlet weak var textFieldBottomConstraint: NSLayoutConstraint!
	
	private let imageChatCellLeft   = "ImageChatCellLeft"
	private let imageChatCellRight  = "ImageChatCellRight"
	private let textChatCellLeft    = "TextChatCellLeft"
	private let textChatCellRight   = "TextChatCellRight"
	var messages: [MessageModel] = [] {
		didSet {
			tableView.reloadData()
			if tableView.numberOfRows(inSection: 0) > 0 {
				tableView.scrollToRow(at: IndexPath.init(row: tableView.numberOfRows(inSection: 0) - 1, section: 0), at: UITableView.ScrollPosition.bottom, animated: false)
			}
			
//			self.chatHeight.constant = min(self.tableView.contentSize.height, 575)
//			self.view.layoutIfNeeded()
		}
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		textField.layer.cornerRadius = textField.frame.height / 2
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		IQKeyboardManager.shared.enable = true
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		IQKeyboardManager.shared.enable = false
		textField.inputAccessoryView = nil
	}
	
	var userId: String?
	override func viewDidLoad() {
		tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
		super.viewDidLoad()
		registerCells()
		navigationController?.navigationBar.isTranslucent = false
		tabBarController?.tabBar.isTranslucent = false
		view.backgroundColor = .white
		NavigationBarDecorator.decorate(self)
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.largeTitleDisplayMode = .always
		self.tableView.contentInsetAdjustmentBehavior = .never
		navigationItem.title = "Чат с менеджером"
		edgesForExtendedLayout = []
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 140
		tableView.showsVerticalScrollIndicator = false
		textField.layer.borderColor = PSColor.silver.cgColor
		textField.layer.borderWidth = 0.8
		textField.autocapitalizationType = .sentences
		setAttributedPlaceholder()
		tableView.contentInset = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)
		ProjectManager.shared.observeMessages(userId: userId) { (messages) in
			self.messages = messages
		}
		let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
		tableView.addGestureRecognizer(tap)
	}
	
	@objc private func tapped() {
		view.endEditing(true)
	}
	
	private func setAttributedPlaceholder() {
		textField.attributedPlaceholder = NSAttributedString(string: "Введите сообщение",
																												 attributes: [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)])
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		IQKeyboardManager.shared.enableAutoToolbar = false
		
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		IQKeyboardManager.shared.enableAutoToolbar = true
		
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	@objc private func handleKeyboard(notification: NSNotification) {
		guard let userInfo = notification.userInfo else { return }
		if let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
			
			let isShowing = notification.name == UIResponder.keyboardWillShowNotification
			textFieldBottomConstraint?.constant = isShowing ? -frame.height+65 : -12
			
			UIView.animate(withDuration: 0) {
				self.view.layoutIfNeeded()
			}
		}
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .default
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
		textField.resignFirstResponder()
	}
	
	func textViewDidChange(_ textView: UITextView) {
//		let newSize = textView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
//		textView.frame = CGRect(origin: textView.frame.origin, size: newSize)
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
