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
		let chatsVc = ChatsViewController()
		navigationController?.pushViewController(chatsVc, animated: true)
	}
  
  @IBAction func createProjectClicked() {
    let vc = CreateProjectViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
	
	@IBAction func requests() {
		navigationController?.pushViewController(RequestsViewController(), animated: true)
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
			Auth.auth().createUser(withEmail: email, password: password, completion: { (_, error) in
				if let txt = error?.localizedDescription {
					self.showAlert(title: "Ошибка", message: txt)
				} else {
					self.showAlert(title: "Done", message: "Юзер создан")
				}
				
			})
			
		}))
		
		present(alertController, animated: true, completion: nil)
	}
	
	@IBAction func changeProjectClicked() {
		let ref = Database.database().reference().child("projects")
		ref.observeSingleEvent(of: .value) { (snapshot) in
			let value = snapshot.value as? [String: Any]
			let keys = value?.keys.map{String($0)} ?? []
			TablePicker.show(fromVC: self, withData: keys, isMultiple: false, title: "Выберите клиентa", andCompletion: { (results) in
				if let first = results.first {
					ref.child(first.formattedEmail()).observeSingleEvent(of: .value, with: { (subsnap) in
						let subValue = subsnap.value as? [String: Any]
						let subIds = subValue?.keys.map{String($0)} ?? []
						TablePicker.show(fromVC: self, withData: subIds, isMultiple: false, title: "Выберите id проекта", andCompletion: { (subresults) in
							if let firstObject = subresults.first {
								delay(delay: 1/2, closure: {
									let countSteps = ((subValue![firstObject] as! [String: Any])["steps"] as! [Any]).count
									let vc = ChangeProjectViewController()
									vc.projectId = firstObject
									vc.stepsCount = countSteps
									vc.emailId = first.formattedEmail()
									self.navigationController?.pushViewController(vc, animated: true)
								})
							}
						})
					})
				}
			})
		}
		
//		let vc = CreateProjectViewController()
//		navigationController?.pushViewController(vc, animated: true)
	}
}
