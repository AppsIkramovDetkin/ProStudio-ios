import UIKit

class PersonalAccount: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	private let aboutUserCell   	= "AboutUserCell"
	private let notificationCell  = "NotificationCell"
	private let exitCell    			= "ExitCell"
	
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
			let cell = tableView.dequeueReusableCell(withIdentifier: aboutUserCell, for: indexPath) as! AboutUserCell
			cell.selectionStyle = .none
			cell.nameSettings()
			
			return cell
		} else if indexPath.row == 1 {
			let cell = tableView.dequeueReusableCell(withIdentifier: aboutUserCell, for: indexPath) as! AboutUserCell
			cell.selectionStyle = .none
			cell.numberSettings()
			
			return cell
		} else if indexPath.row == 2 {
			let cell = tableView.dequeueReusableCell(withIdentifier: aboutUserCell, for: indexPath) as! AboutUserCell
			cell.mailSettings()
			cell.selectionStyle = .none
			
			return cell
		} else if indexPath.row == 3 {
			let cell = tableView.dequeueReusableCell(withIdentifier: notificationCell, for: indexPath) as! NotificationCell
			cell.selectionStyle = .none
			
			return cell
		} else if indexPath.row == 4 {
			let cell = tableView.dequeueReusableCell(withIdentifier: exitCell, for: indexPath) as! ExitCell
			cell.selectionStyle = .none
			
			return cell
		}
		return UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return view.frame.size.height * 0.4983
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let frame: CGRect = tableView.frame
		
		let headerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: view.frame.size.height * 0.4983))
		headerView.backgroundColor = CustomColors.cerulean
		
		let headerViewInfo = UIView(frame: CGRect(x: 0, y: view.frame.size.height * 0.273, width: frame.size.width, height: view.frame.size.height * 0.227))
		headerViewInfo.backgroundColor = UIColor.white
		headerView.addSubview(headerViewInfo)
		
		let backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: view.frame.size.height * 0.2713))
		backgroundImage.image = UIImage(named: "photo")?.alpha(0.1)
		headerView.addSubview(backgroundImage)
		
		let avatar: UIImageView = UIImageView(frame: CGRect(x: (frame.size.width / 2) - 79, y: frame.size.height * 0.1711, width: 158, height: 158))
		avatar.image = UIImage(named: "photo")
		avatar.layer.cornerRadius = avatar.frame.size.width / 2
		avatar.clipsToBounds = true
		headerView.addSubview(avatar)
		
		let avatarBorder: UIView = UIView(frame: CGRect(x: (frame.size.width / 2) - 79.5, y: frame.size.height * 0.1711, width: 159, height: 159))
		avatarBorder.layer.cornerRadius = avatarBorder.frame.size.width / 2
		avatarBorder.layer.borderWidth = 11
		avatarBorder.layer.borderColor = UIColor(netHex: 0xffffff).cgColor
		avatarBorder.clipsToBounds = true
		headerView.addSubview(avatarBorder)
		
	  let personalAccountLabel = UILabel(frame: CGRect(x: 14, y: frame.size.height * 0.105, width: 295.57, height: 36))
		personalAccountLabel.text = "Личный кабинет"
		personalAccountLabel.font = CustomFonts.headerText
		personalAccountLabel.textColor = UIColor.white
		headerView.addSubview(personalAccountLabel)
		
		let nameLabel = UILabel(frame: CGRect(x: 0, y: frame.size.height * 0.39244, width: view.frame.width, height: 27.5))
		nameLabel.textAlignment = NSTextAlignment.center
		nameLabel.text = "Филиппов Михаил"
		nameLabel.font = CustomFonts.nameFont
		nameLabel.textColor = UIColor(cgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
		headerView.addSubview(nameLabel)
		
		let companyNameLabel = UILabel(frame: CGRect(x: 0, y: (frame.size.height * 0.39244) + 27.5, width: view.frame.width, height: 27.5))
		companyNameLabel.text = "Цифровая Империя"
		companyNameLabel.textAlignment = NSTextAlignment.center
		companyNameLabel.font = CustomFonts.companyFont
		companyNameLabel.textColor = CustomColors.companyNameColor
		headerView.addSubview(companyNameLabel)
		
		let line = UIView(frame: CGRect(x: 0, y: view.frame.height * 0.498357, width: view.frame.width, height: 0.36))
		line.backgroundColor = CustomColors.grayLine
		line.clipsToBounds = true
		headerView.addSubview(line)
		
		return headerView
	}
	
	private func registerCells() {
		tableView.register(UINib(nibName: aboutUserCell, bundle: nil), forCellReuseIdentifier: aboutUserCell)
		tableView.register(UINib(nibName: notificationCell, bundle: nil), forCellReuseIdentifier: notificationCell)
		tableView.register(UINib(nibName: exitCell, bundle: nil), forCellReuseIdentifier: exitCell)
	}
}
