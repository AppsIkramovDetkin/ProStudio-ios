//
//  ProjectDiscussionTableViewController.swift
//  ProStudio
//
//  Created by Zimma on 10/10/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit
import MessageUI

class ProjectDiscussion: UITableViewController, MFMailComposeViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	
	private let textFieldCell = "TextFieldCell"
	private let buttonCell = "ButtonCell"
	private let projectTypes: [ProjectType] = [.analytics, .appsAndSites, .branding, .seo]
	private let typePickerView = UIPickerView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationController?.navigationBar.noTransparent()
        navigationController?.navigationBar.barStyle = .black
		NavigationBarDecorator.decorate(self)
		tableView.separatorColor = .clear
		tableView.isScrollEnabled = true
		tableView.allowsSelection = false
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.largeTitleDisplayMode = .always
		
		title = "Обсудить проект"
		tableView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
		typePickerView.delegate = self
		typePickerView.dataSource = self
		registerCells()
		
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.transparentNavigationBar()
		navigationController?.navigationBar.barStyle = .black
	}
	
	var showed = false
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		if !showed {
			if let cell = tableView.cellForRow(at: IndexPath.init(row: 3, section: 0)) as? TextFieldCell {
				delay(delay: 0.5) {
					cell.textField.becomeFirstResponder()
				}
				showed = true
			}
		}
		
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return projectTypes.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return projectTypes[row].rawValue
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		projectType = projectTypes[row].rawValue
		if let cell = tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as? TextFieldCell {
			cell.textField.text = projectType
		}
		
		
	}
	
	// MARK: - Table view data source
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 6
	}
	
    var projectType: String = ""
    var name: String = ""
    var phone: String = ""
    var email: String = ""
    var comment: String = ""
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		switch indexPath.row {
		case 0:
			
			let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCell, for: indexPath) as! TextFieldCell
			cell.textField.placeholderText = "Выберите вид проекта"
			cell.textField.tag = 0
            cell.textChanged  = { self.projectType = $0 }
			cell.textField.addRightButton()
			cell.textField.rightButton.addTarget(self, action: #selector(textFieldButtonAction(button:)), for: .touchUpInside)
			cell.textField.inputView = typePickerView
			cell.textField.text = projectType
			return cell
			
		case 1:
			
			let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCell, for: indexPath) as! TextFieldCell
			cell.textField.placeholderText = "Имя"
            cell.textChanged  = { self.name = $0 }
			cell.textField.text = name
			cell.textField.tag = 1
			return cell
			
		case 2:
			
			let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCell, for: indexPath) as! TextFieldCell
			cell.textField.placeholderText = "Телефон"
            cell.textField.keyboardType = .phonePad
            cell.textChanged  = { self.phone = $0 }
			cell.textField.tag = 2
			cell.textField.text = phone
			return cell
		case 3:
			
			let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCell, for: indexPath) as! TextFieldCell
			cell.textField.placeholderText = "Email"
            cell.textField.keyboardType = .emailAddress
            cell.textChanged  = { self.email = $0 }
			cell.textField.tag = 3
			cell.textField.text = email
			return cell
			
		case 4:
			
			let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCell, for: indexPath) as! TextFieldCell
			cell.textField.placeholderText = "Комментарий"
            cell.textChanged  = { self.comment = $0 }
			cell.textField.tag = 4
			cell.textField.text = comment
			return cell
			
		case 5:
			
			let cell = tableView.dequeueReusableCell(withIdentifier: buttonCell, for: indexPath) as! ButtonCell
			cell.button.setTitle("ОТПРАВИТЬ", for: .normal)
            cell.touched = {
                guard !self.name.isEmpty, !self.projectType.isEmpty, !self.phone.isEmpty, !self.email.isEmpty else {
                    self.showAlert(title: "Ошибка", message: "Заполните все поля")
                    return
                }
                if MFMailComposeViewController.canSendMail() {
                    let mail = MFMailComposeViewController()
                    mail.mailComposeDelegate = self
                    mail.setToRecipients(["vsexmogushiy@gmail.com"])
                    mail.setMessageBody([self.name, self.projectType, self.comment, self.email, self.phone, self.comment].filter{!$0.isEmpty}.joined(separator: ", "), isHTML: false)
                    
                    self.present(mail, animated: true)
                } else {
                    self.showAlert(title: "Ошибка", message: "Отправка Email недоступна")
                    // show failure alert
                }
            }
			return cell
			
		default:
			return UITableViewCell()
		}
		
	}
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
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
