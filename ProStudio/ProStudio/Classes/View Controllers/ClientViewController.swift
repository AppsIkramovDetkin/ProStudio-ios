//
//  ClientViewController.swift
//  ProStudio
//
//  Created by Ruslan Prozhivin on 21/01/2019.
//  Copyright © 2019 Nikita. All rights reserved.
//

import UIKit

class ClientViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	
	private let textFieldCell = "TextFieldCell"
	private let buttonCell = "ButtonCell"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		delegating()
		customNavBar()
		registerNibs()
		self.title = "Клиент"
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

extension ClientViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			let cell = UITableViewCell()
			cell.selectionStyle = .none
			cell.backgroundColor = UIColor.clear
			return cell
		} else if indexPath.row == 1 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! LabelCell
			cell.label.text = "ИМЯ КЛИЕНТА"
			cell.label.textColor = UIColor(red: 142, green: 142, blue: 147)
			cell.backgroundColor = UIColor.clear
			return cell
		} else if indexPath.row == 2 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for: indexPath) as! StandartTextFieldCell
			cell.textField.placeholder = "Введите ваше ФИО"
			cell.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
			return cell
		} else if indexPath.row == 3 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! LabelCell
			cell.label.text = "КОМПАНИЯ"
			cell.label.textColor = UIColor(red: 142, green: 142, blue: 147)
			cell.backgroundColor = UIColor.clear
			return cell
		} else if indexPath.row == 4 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for: indexPath) as! StandartTextFieldCell
			cell.textField.placeholder = "Введите название компании"
			cell.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
			return cell
		} else if indexPath.row == 5 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! LabelCell
			cell.label.text = "ПОЧТА"
			cell.label.textColor = UIColor(red: 142, green: 142, blue: 147)
			cell.backgroundColor = UIColor.clear
			return cell
		} else if indexPath.row == 6 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for: indexPath) as! StandartTextFieldCell
			cell.textField.placeholder = "Введите почту"
			cell.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
			return cell
		} else if indexPath.row == 7 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! LabelCell
			cell.label.text = "ДАТА ДОБАВЛЕНИЯ"
			cell.label.textColor = UIColor(red: 142, green: 142, blue: 147)
			cell.backgroundColor = UIColor.clear
			return cell
		} else if indexPath.row == 8 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for: indexPath) as! StandartTextFieldCell
			cell.textField.placeholder = "Дата добавления"
			cell.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
			return cell
		} else if indexPath.row == 9 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! LabelCell
			cell.label.text = "ПАРОЛЬ ДЛЯ ВХОДА"
			cell.label.textColor = UIColor(red: 142, green: 142, blue: 147)
			cell.backgroundColor = UIColor.clear
			return cell
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for: indexPath) as! StandartTextFieldCell
			cell.textField.placeholder = "Введите пароль"
			cell.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
			return cell
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 11
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 0 {
			return 22
		} else {
			return 44
		}
	}
}
