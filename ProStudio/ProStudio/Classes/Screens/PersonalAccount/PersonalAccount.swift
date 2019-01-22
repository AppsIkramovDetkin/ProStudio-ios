import UIKit
import FirebaseDatabase
import FirebaseAuth

class PersonalAccount: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	private enum CellId: String {
		case headerView = "HeaderView"
		case aboutUserCell = "AboutUserCell"
		case notificationCell = "NotificationCell"
		case exitCell = "ExitCell"
	}
	
	var name: String? {
		didSet {
			updateHeader()
			tableView.reloadData()
		}
	}
	
	var phone: String? {
		didSet {
			tableView.reloadData()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.largeTitleDisplayMode = .always
		title = "Личный кабинет"
		registerCells()
		tableView.separatorInset = .zero
		tableView.isScrollEnabled = true
		updateHeader()
		tableView.tableFooterView = UIView()
		tableView.showsVerticalScrollIndicator = false
		Database.database().reference().child("users").child((currentUser.email ?? "").formattedEmail()).observe(.value) { (snapshot) in
			if let value = snapshot.value as? [String: String] {
				self.name = value["name"]
				self.phone = value["phone"]
			}
		}
	}
	
	func updateHeader() {
		let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CellId.headerView.rawValue) as! HeaderView
		headerView.userName.text = name ?? currentUser.email
		tableView.tableHeaderView = headerView
	}
	
	override var preferredStatusBarStyle : UIStatusBarStyle {
		return .lightContent
	}
	
}

extension PersonalAccount: UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		switch textField.placeholder {
		case "Введите имя":
			Database.database().reference().child("users").child(currentUser.email!.formattedEmail()).child("name").setValue(textField.text)
		case "Введите телефон":
			Database.database().reference().child("users").child(currentUser.email!.formattedEmail()).child("phone").setValue(textField.text)
		default: break
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.row {
		case 4:
			try? Auth.auth().signOut()
			currentUser = nil
			let domain = Bundle.main.bundleIdentifier!
			UserDefaults.standard.removePersistentDomain(forName: domain)
			UserDefaults.standard.synchronize()
			dismiss(animated: true) {
				(UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController?.dismiss(animated: true, completion: nil)
			}
		default: break
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return indexPath.row == 3 ? 52 : 60
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if indexPath.row == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellId.aboutUserCell.rawValue, for: indexPath) as! AboutUserCell
			cell.mailSettings()
			cell.selectionStyle = .none
			cell.aboutUserTextField.isUserInteractionEnabled = false
			cell.aboutUserTextField.text = currentUser.email
			return cell
		} else if indexPath.row == 2 {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellId.notificationCell.rawValue, for: indexPath) as! NotificationCell
			cell.selectionStyle = .none
			
			return cell
			
		} else if indexPath.row == 1 {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellId.aboutUserCell.rawValue, for: indexPath) as! AboutUserCell
			cell.selectionStyle = .none
			cell.numberSettings()
			cell.aboutUserTextField.text = phone
			cell.aboutUserTextField.delegate = self
			cell.aboutUserTextField.placeholder = "Введите телефон"
			return cell
			
		} else if indexPath.row == 3 {
			return UITableViewCell()
			
		} else if indexPath.row == 4 {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellId.exitCell.rawValue, for: indexPath) as! ExitCell
			cell.selectionStyle = .none
			
			return cell
		}
		return UITableViewCell()
	}
	
	private func registerCells() {
		tableView.register(UINib(nibName: CellId.aboutUserCell.rawValue, bundle: nil), forCellReuseIdentifier: CellId.aboutUserCell.rawValue)
		tableView.register(UINib(nibName: CellId.notificationCell.rawValue, bundle: nil), forCellReuseIdentifier: CellId.notificationCell.rawValue)
		tableView.register(UINib(nibName: CellId.exitCell.rawValue, bundle: nil), forCellReuseIdentifier: CellId.exitCell.rawValue)
		tableView.register(UINib.init(nibName: CellId.headerView.rawValue, bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: CellId.headerView.rawValue)
	}
}
