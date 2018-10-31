import UIKit

class PersonalAccount: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	private enum CellId: String {
		case headerView = "HeaderView"
		case aboutUserCell = "AboutUserCell"
		case notificationCell = "NotificationCell"
		case exitCell = "ExitCell"
	}

	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		registerCells()
		tableView.isScrollEnabled = false
	}

	override var preferredStatusBarStyle : UIStatusBarStyle {
		return .lightContent
	}
	
}

extension PersonalAccount: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return view.frame.height * 0.0825
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellId.aboutUserCell.rawValue, for: indexPath) as! AboutUserCell
			cell.selectionStyle = .none
			cell.nameSettings()
			
			return cell
		} else if indexPath.row == 1 {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellId.aboutUserCell.rawValue, for: indexPath) as! AboutUserCell
			cell.selectionStyle = .none
			cell.numberSettings()
			
			return cell
		} else if indexPath.row == 2 {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellId.aboutUserCell.rawValue, for: indexPath) as! AboutUserCell
			cell.mailSettings()
			cell.selectionStyle = .none
			
			return cell
		} else if indexPath.row == 3 {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellId.notificationCell.rawValue, for: indexPath) as! NotificationCell
			cell.selectionStyle = .none
			
			return cell
		} else if indexPath.row == 4 {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellId.exitCell.rawValue, for: indexPath) as! ExitCell
			cell.selectionStyle = .none
			
			return cell
		}
		return UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return view.frame.size.height * 0.4983
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CellId.headerView.rawValue) as! HeaderView
		
		return headerView
	}
	
	private func registerCells() {
		tableView.register(UINib(nibName: CellId.aboutUserCell.rawValue, bundle: nil), forCellReuseIdentifier: CellId.aboutUserCell.rawValue)
		tableView.register(UINib(nibName: CellId.notificationCell.rawValue, bundle: nil), forCellReuseIdentifier: CellId.notificationCell.rawValue)
		tableView.register(UINib(nibName: CellId.exitCell.rawValue, bundle: nil), forCellReuseIdentifier: CellId.exitCell.rawValue)
		tableView.register(UINib.init(nibName: CellId.headerView.rawValue, bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: CellId.headerView.rawValue)
	}
}
