//
//  AdminViewController.swift
//  ProStudio
//
//  Created by Hadevs on 02/12/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit
import Firebase

class AdminViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.setNavigationBarHidden(false, animated: true)
		let rightButton = UIBarButtonItem.init(title: "Чат", style: .plain, target: self, action: #selector(gotochat))
		navigationItem.rightBarButtonItem = rightButton
  }
	
	@objc private func gotochat() {
		let projectsVC = AdminProjectsViewController()
		projectsVC.projectSelected = {
			project in
			projectsVC.navigationController?.popViewController(animated: true)
			let vc = ChatWithManager()
			vc.userId = project.client.formattedEmail()
			self.navigationController?.pushViewController(vc, animated: true)
		}
		navigationController?.pushViewController(projectsVC, animated: true)
	}
  
  @IBAction func createProjectClicked() {
    let vc = AddProjectViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
	
	@IBAction func requests() {
		navigationController?.pushViewController(AdminClientsViewController(), animated: true)
	}
	
	@IBAction func endProject() {
	let ref = Database.database().reference().child("projects")
		let projectsVC = AdminProjectsViewController()
		projectsVC.projectSelected = {
			project in
			projectsVC.navigationController?.popViewController(animated: true)
			
			ref.child(project.client.formattedEmail()).child(project.id).child("progress").setValue(100)
			ref.child(project.client.formattedEmail()).child(project.id).child("isEnded").setValue(true)
			delay(delay: 1/2, closure: {
				self.showAlertWithOneAction(title: "Проект заврешен", message: "", handle: {
					
				})
			})
			
		}
		navigationController?.pushViewController(projectsVC, animated: true)
	}
	
	@IBAction func changeUser() {
//		let usersvc = AdminClientsViewController()
//		
//		let ref = Database.database().reference().child("users")
//		ref.observeSingleEvent(of: .value) { (snapshot) in
//			let value = snapshot.value as? [String: [String: Any]]
//			let keys = value?.keys.map{String($0)} ?? []
//			
//			TablePicker.show(fromVC: self, withData: keys, isMultiple: false, title: "Выберите id юзера", andCompletion: { (results) in
//				delay(delay: 1, closure: {
//					let id = results[0]
//					let changeUserVC = ChangeUserViewController()
//					changeUserVC.userId = id
//					let userDict = value?[id]
//					let name = userDict?["name"] as? String
//					let phone = userDict?["phone"] as? String
//					changeUserVC.phone = phone
//					changeUserVC.name = name
//					self.navigationController?.pushViewController(changeUserVC, animated: true)
//				})
//			})
//		}
		
	}
	
	@IBAction func addClient() {
		let alertController = UIAlertController(title: "Добавить клиента", message: "Введите данные клиента", preferredStyle: .alert)
		alertController.addTextField { (f) in
			f.placeholder = "Email"
		}
		
		alertController.addTextField { (f) in
			f.placeholder = "Пароль"
		}
		
		alertController.addAction(UIAlertAction.init(title: "Готово", style: .default, handler: { (_) in
			let email = alertController.textFields![0].text ?? ""
			let password = alertController.textFields![1].text ?? ""
			ProjectManager.shared.createUser(email: email, password: password, closure: {
				self.showAlert(title: "Done", message: "Юзер создан")
			})
		}))
		
		alertController.addAction(UIAlertAction.init(title: "Отменить", style: .cancel, handler: nil))
		
		present(alertController, animated: true, completion: nil)
	}
	
	@IBAction func changeProjectClicked() {
		let projectsVC = AdminProjectsViewController()
		projectsVC.projectSelected = {
			project in
			projectsVC.navigationController?.popViewController(animated: true)
			let vc = AdminControlViewController(project: project)
			
			self.navigationController?.pushViewController(vc, animated: true)
		}
		navigationController?.pushViewController(projectsVC, animated: true)
		
	}
}
