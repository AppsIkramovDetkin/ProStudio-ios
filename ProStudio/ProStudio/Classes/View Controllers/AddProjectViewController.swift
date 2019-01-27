//
//  AddProjectViewController.swift
//  ProStudio
//
//  Created by Ruslan Prozhivin on 21/01/2019.
//  Copyright © 2019 Nikita. All rights reserved.
//

import UIKit
import Firebase

class AddProjectViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	
	private let textFieldCell = "TextFieldCell"
	private let buttonCell = "ButtonCell"
	private var isOnCheckButton = false
	private var isOnDevelopment = false
	private var isOnBranding = false
	private var isOnPromotion = false
	private var isOnAnalytics = false
	var project: Project = Project()
	let datepicker = UIDatePicker()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		delegating()
		registerNibs()
		customNavBar()
		self.title = "Добавить проект"
		datepicker.addTarget(self, action: #selector(datechanged(sender:)), for: .valueChanged)
	}
	
	@objc private func datechanged(sender: UIDatePicker) {
		project.startDate = sender.date.timeIntervalSince1970
		tableView.reloadData()
	}
	
	private func customNavBar() {
		if #available(iOS 11.0, *) {
			self.navigationController?.navigationBar.prefersLargeTitles = true
			self.navigationItem.largeTitleDisplayMode = .always
		}
	}
	
	private func delegating() {
		tableView.delegate = self
		tableView.dataSource = self
	}
	
	private func registerNibs() {
		tableView.register(UINib(nibName: "LabelCell", bundle: nil), forCellReuseIdentifier: "labelCell")
		tableView.register(UINib(nibName: "LabelWithCheckMarkCell", bundle: nil), forCellReuseIdentifier: "labelMarkCell")
		tableView.register(UINib(nibName: "StandartTextFieldCell", bundle: nil), forCellReuseIdentifier: "textFieldCell")
		tableView.register(UINib(nibName: textFieldCell, bundle: nil), forCellReuseIdentifier: textFieldCell)
		tableView.register(UINib(nibName: buttonCell, bundle: nil), forCellReuseIdentifier: buttonCell)
	}
}

extension AddProjectViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			let cell = UITableViewCell()
			cell.selectionStyle = .none
			cell.backgroundColor = UIColor.clear
			return cell
		} else if indexPath.row == 1 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! LabelCell
			cell.label.text = "НАЗВАНИЕ ПРОЕКТА"
			cell.label.textColor = UIColor(red: 142, green: 142, blue: 147)
			cell.backgroundColor = UIColor.clear
			return cell
		} else if indexPath.row == 2 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for: indexPath) as! StandartTextFieldCell
			cell.textField.placeholder = "Выберите название проекта"
			cell.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
			cell.textChanged = {
				text in
				
				self.project.name = text
			}
			return cell
		} else if indexPath.row == 3 {
			let cell = UITableViewCell()
			cell.selectionStyle = .none
			cell.backgroundColor = UIColor.clear
			return cell
		} else if indexPath.row == 4 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! LabelCell
			cell.label.text = "КАТЕГОРИЯ ПРОЕКТА"
			cell.label.textColor = UIColor(red: 142, green: 142, blue: 147)
			cell.backgroundColor = UIColor.clear
			return cell
		} else if indexPath.row == 5 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "labelMarkCell", for: indexPath) as! LabelWithCheckMarkCell
			cell.label.text = "Разработка"
			if isOnDevelopment == true {
				cell.checkMarkImageView.isHidden = false
			} else {
				cell.checkMarkImageView.isHidden = true
			}
			cell.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
			cell.label.textColor = UIColor(red: 0, green: 129, blue: 204)
			return cell
		} else if indexPath.row == 6 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "labelMarkCell", for: indexPath) as! LabelWithCheckMarkCell
			cell.label.text = "Брендинг"
			if isOnBranding == true {
				cell.checkMarkImageView.isHidden = false
			} else {
				cell.checkMarkImageView.isHidden = true
			}
			cell.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
			cell.label.textColor = UIColor(red: 247, green: 194, blue: 0)
			return cell
		} else if indexPath.row == 7 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "labelMarkCell", for: indexPath) as! LabelWithCheckMarkCell
			cell.label.text = "Продвижение"
			if isOnPromotion == true {
				cell.checkMarkImageView.isHidden = false
			} else {
				cell.checkMarkImageView.isHidden = true
			}
			cell.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
			cell.label.textColor = UIColor(red: 142, green: 28, blue: 119)
			return cell
		} else if indexPath.row == 8 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "labelMarkCell", for: indexPath) as! LabelWithCheckMarkCell
			cell.label.text = "Аналитика"
			if isOnAnalytics == true {
				cell.checkMarkImageView.isHidden = false
			} else {
				cell.checkMarkImageView.isHidden = true
			}
			cell.label.textColor = UIColor(red: 219, green: 33, blue: 73)
			return cell
		} else if indexPath.row == 9 {
			let cell = UITableViewCell()
			cell.selectionStyle = .none
			cell.backgroundColor = UIColor.clear
			return cell
		} else if indexPath.row == 10 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! LabelCell
			cell.label.text = "ДАТА НАЧАЛА ПРОЕКТА"
			cell.label.textColor = UIColor(red: 142, green: 142, blue: 147)
			cell.backgroundColor = UIColor.clear
			return cell
		} else if indexPath.row == 11 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for: indexPath) as! StandartTextFieldCell
			cell.textField.placeholder = "Выберите дату начала проекта"
			cell.textField.inputView = datepicker
			cell.textField.text = project.getStartDate().convertFormateToNormDateString(format: "dd.MM.yyyy")
			cell.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
			return cell
		} else if indexPath.row == 12 {
			let cell = tableView.dequeueReusableCell(withIdentifier: buttonCell, for: indexPath) as! ButtonCell
			cell.button.setTitle("ДОБАВИТЬ ПРОЕКТ", for: .normal)
			cell.backgroundColor = UIColor.clear
			cell.touched = buttonClicked
			return cell
		}
		return UITableViewCell()
	}
	
	func buttonClicked() {
		let vc = AdminClientsViewController()
		vc.userSelected = { user in
			vc.navigationController?.popViewController(animated: true)
			let email = user.email
			let projectName = self.project.name
			guard !email.isEmpty && !projectName.isEmpty else {
				self.showAlert(title: "ошибка", message: "Заполните почту клиента, имя проекта и этапы")
				return
			}
			func date(_ str: String) -> Date {
				let dateFormatter = DateFormatter()
				dateFormatter.dateFormat = "dd.MM.yyyy"
				return dateFormatter.date(from: str)!
			}
			
			let ref = Database.database().reference()
			
			let id = ID()
			let step = ProjectStep()
			step.endDate = Date().timeIntervalSince1970
			step.isEnded = false
			step.name = "Начало проекта"
			let dict = [
				"id": id,
				"client": email,
				"type": self.project.type,
				"startDate": self.project.startDate,
				"endDate": self.project.endDate,
				"name": projectName,
				"isEnded": false,
				"progress": 0,
				"steps": [step.dictionary!]
				] as [String : Any]
			
			ref.child("projects").child(email.formattedEmail()).child(id).setValue(dict)
			self.showAlertWithOneAction(title: "Готово", message: "Проект создан") {
				self.navigationController?.popViewController(animated: true)
			}
		}
		navigationController?.pushViewController(vc, animated: true)
	}
	
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 9 {
			return 22
		} else if indexPath.row == 1 || indexPath.row == 10 || indexPath.row == 4 {
			return 33
		} else if indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 8 {
			return 44
		} else if indexPath.row == 12 {
			return 60
		} else {
			return 44
		}
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row == 5 {
			isOnDevelopment = true
			isOnBranding = false
			isOnAnalytics = false
			isOnPromotion = false
			tableView.reloadData()
			project.type = ProjectType.appsAndSites.rawValue
		}
		
		if indexPath.row == 6 {
			isOnDevelopment = false
			isOnBranding = true
			isOnAnalytics = false
			isOnPromotion = false
			tableView.reloadData()
			project.type = ProjectType.branding.rawValue
		}
		
		if indexPath.row == 7 {
			isOnDevelopment = false
			isOnBranding = false
			isOnAnalytics = false
			isOnPromotion = true
			tableView.reloadData()
			project.type = ProjectType.seo.rawValue
			
		}
		
		if indexPath.row == 8 {
			isOnDevelopment = false
			isOnBranding = false
			isOnAnalytics = true
			isOnPromotion = false
			tableView.reloadData()
			project.type = ProjectType.analytics.rawValue
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 13
	}
}
