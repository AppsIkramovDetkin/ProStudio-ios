//
//  ChatsViewController.swift
//  ProStudio
//
//  Created by Hadevs on 06/01/2019.
//  Copyright © 2019 Nikita. All rights reserved.
//

import UIKit
import Firebase

class RequestsViewController: UITableViewController {
	
	var ids: [String] = [] {
		didSet {
			tableView.reloadData()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		Database.database().reference().child("requests").observe(.value) { (snapshot) in
			self.ids.removeAll()
			for child in (snapshot.value as? [String: Any] ?? [:]) {
				self.ids.append(child.key)
			}
		}
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		cell.textLabel?.text = ids[indexPath.row]
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let alert = UIAlertController(title: "Принятие", message: "Вы хотите зарегистрировать пользователя с почтой \(ids[indexPath.row])?", preferredStyle: .alert)
		alert.addAction(UIAlertAction.init(title: "Да", style: .default, handler: { (_) in
			let alertController = UIAlertController(title: "Добавить клиента", message: "Введите данные клиента", preferredStyle: .alert)
			alertController.addTextField { (f) in
				f.placeholder = "Email"
				f.text = self.ids[indexPath.row]
			}
			
			alertController.addTextField { (f) in
				f.placeholder = "Пароль"
				f.becomeFirstResponder()
			}
			
			alertController.addAction(UIAlertAction.init(title: "Готово", style: .default, handler: { (_) in
				let email = alertController.textFields![0].text ?? ""
				let password = alertController.textFields![1].text ?? ""
				Auth.auth().createUser(withEmail: email, password: password, completion: { (_, error) in
					if let txt = error?.localizedDescription {
						self.showAlert(title: "Ошибка", message: txt)
					} else {
						self.showAlert(title: "Done", message: "Юзер создан")
					}
				})
				
			}))
			
			self.present(alertController, animated: true, completion: nil)
		}))
		alert.addAction(UIAlertAction.init(title: "Нет", style: .default, handler: { (_) in
			
		}))
		present(alert, animated: true, completion: nil)
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return ids.count
	}
	
}
