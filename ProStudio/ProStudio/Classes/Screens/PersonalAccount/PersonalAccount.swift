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
		navigationItem.title = "Личный кабинет"
		registerCells()
		NavigationBarDecorator.decorate(self)
		tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
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
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.row {
		case 5:
			try? Auth.auth().signOut()
			currentUser = nil
			let domain = Bundle.main.bundleIdentifier!
			UserDefaults.standard.removePersistentDomain(forName: domain)
			UserDefaults.standard.synchronize()
			dismiss(animated: true) {
				(UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController?.dismiss(animated: true, completion: nil)
			}
		case 3:
			let vc = SecurityScreen()
			vc.isRegister = true
			present(vc, animated: true, completion: nil)
		default: break
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 6
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
			cell.switchControl.isHidden = false
			return cell
		} else if indexPath.row == 1 {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellId.aboutUserCell.rawValue, for: indexPath) as! AboutUserCell
			cell.selectionStyle = .none
			cell.numberSettings()
			cell.aboutUserTextField.text = phone
			cell.aboutUserTextField.delegate = self
			cell.aboutUserTextField.isUserInteractionEnabled = false
			cell.aboutUserTextField.placeholder = ""
			return cell
			
		} else if indexPath.row == 4 {
			let cell = UITableViewCell()
			cell.separatorInset = .zero
			return cell
			
		} else if indexPath.row == 5 {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellId.exitCell.rawValue, for: indexPath) as! ExitCell
			cell.selectionStyle = .none
			cell.separatorInset = .zero
			return cell
		} else if indexPath.row == 3 {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellId.notificationCell.rawValue, for: indexPath) as! NotificationCell
			cell.selectionStyle = .none
			cell.separatorInset = .zero
			cell.switchControl.isHidden = true
			cell.accessoryType = .disclosureIndicator
			cell.notificationLabel.text = "Сменить код-доступа"
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
