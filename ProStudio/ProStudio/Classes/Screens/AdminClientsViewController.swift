//
//  AdminClientsViewController.swift
//  ProStudio
//
//  Created by Hadevs on 20/01/2019.
//  Copyright © 2019 Nikita. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AdminClientsViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	
	lazy var searchController = SearchController<PSUser>(users + requestUsers)
	
	var users: [PSUser] = []
	var requestUsers: [PSUser] = []
	
	lazy var resultSearchController = { () -> UISearchController in
		let c = UISearchController(searchResultsController: nil)
		c.searchResultsUpdater = self
		c.dimsBackgroundDuringPresentation = false
		c.searchBar.sizeToFit()
		tableView.tableHeaderView = c.searchBar
		return c
	}()
	
	var userSelected: ItemClosure<PSUser>?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		resultSearchController.dimsBackgroundDuringPresentation = false
		tableView.delegate = self
		tableView.dataSource = self
		
		ProjectManager.shared.loadAllUsers { (users) in
			self.users = users
			self.tableView.reloadData()
		}
		
		ProjectManager.shared.loadAllRequests { (users) in
			self.requestUsers = users
			self.tableView.reloadData()
		}
	}
	
	func split(users: [PSUser]) {
		var r: [PSUser] = []
		var u: [PSUser] = []
 		for c in users {
			if c.email == c.id {
				r.append(c)
			} else {
				u.append(c)
			}
		}
		
		self.requestUsers = r
		self.users = u
		tableView.reloadData()
	}
}

extension AdminClientsViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		let text = searchController.searchBar.text
		let filteredProjects = self.searchController.search(by: text)
		split(users: filteredProjects)
		tableView.reloadData()
	}
}

extension AdminClientsViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.section == 0 {
			userSelected?(users[indexPath.row])
		} else {
			let id = requestUsers[indexPath.row].id
			let alert = UIAlertController(title: "Принятие", message: "Вы хотите зарегистрировать пользователя с почтой \(id)?", preferredStyle: .alert)
			alert.addAction(UIAlertAction.init(title: "Да", style: .default, handler: { (_) in
				let alertController = UIAlertController(title: "Добавить клиента", message: "Введите данные клиента", preferredStyle: .alert)
				alertController.addTextField { (f) in
					f.placeholder = "Email"
					f.text = id
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
	}
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
		case 0: return "ВСЕ КЛИЕНТЫ"
		default: return "ЗАПРОСЫ НА ДОБАВЛЕНИЕ КЛИЕНТА"
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let projec: PSUser = {
			switch indexPath.section {
			case 0: return users[indexPath.row]
			default: return requestUsers[indexPath.row]
			}
		}()
		let cell = UITableViewCell()
		cell.textLabel?.text = "\(projec.email)"
		return cell
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return users.count
		} else {
			return requestUsers.count
		}
	}
}
