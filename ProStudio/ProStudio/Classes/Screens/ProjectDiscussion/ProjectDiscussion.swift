//
//  ProjectDiscussionTableViewController.swift
//  ProStudio
//
//  Created by Zimma on 10/10/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit

class ProjectDiscussion: UITableViewController {
	
	private let textFieldCell = "TextFieldCell"
	private let buttonCell = "ButtonCell"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		NavigationBarDecorator.decorate(self)
		tableView.separatorColor = .clear
		tableView.isScrollEnabled = false
		tableView.allowsSelection = false
		navigationController?.navigationBar.prefersLargeTitles = true
		title = "Обсудить проект"
		tableView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
		registerCells()
		
	}
	
	// MARK: - Table view data source
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 6
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		switch indexPath.row {
		case 0:
			
			let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCell, for: indexPath) as! TextFieldCell
			cell.textField.placeholderText = "Выберите вид проекта"
			cell.textField.tag = 0
			cell.textField.addRightButton()
			cell.textField.rightButton.addTarget(self, action: #selector(textFieldButtonAction(button:)), for: .touchUpInside)
			return cell
			
		case 1:
			
			let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCell, for: indexPath) as! TextFieldCell
			cell.textField.placeholderText = "Имя"
			cell.textField.tag = 1
			return cell
			
		case 2:
			
			let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCell, for: indexPath) as! TextFieldCell
			cell.textField.placeholderText = "Телефон"
			cell.textField.tag = 2
			return cell
		case 3:
			
			let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCell, for: indexPath) as! TextFieldCell
			cell.textField.placeholderText = "Email"
			cell.textField.tag = 3
			return cell
			
		case 4:
			
			let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCell, for: indexPath) as! TextFieldCell
			cell.textField.placeholderText = "Комментарий"
			cell.textField.tag = 4
			return cell
			
		case 5:
			
			let cell = tableView.dequeueReusableCell(withIdentifier: buttonCell, for: indexPath) as! ButtonCell
			cell.button.setTitle("ОТПРАВИТЬ", for: .normal)
			return cell
			
		default:
			return UITableViewCell()
		}
		
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 70
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print(indexPath.row)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
	}
	
	@objc func textFieldButtonAction(button: UIButton) {
		print("This is button in textField!")
	}
	
	private func registerCells() {
		tableView.register(UINib(nibName: textFieldCell, bundle: nil), forCellReuseIdentifier: textFieldCell)
		tableView.register(UINib(nibName: buttonCell, bundle: nil), forCellReuseIdentifier: buttonCell)
	}
	
}
