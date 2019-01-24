//
//  AdminControlViewController.swift
//  ProStudio
//
//  Created by Hadevs on 21/01/2019.
//  Copyright © 2019 Nikita. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class AdminControlViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	
	var project: Project!
	
	convenience init(project: Project) {
		self.init()
		self.project = project
	}
	var newStepPicker = UIDatePicker(frame: .zero)
	
	var newStepDate: Date {
		return newStepPicker.date
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "s")
		let b = UIBarButtonItem(title: "Добавить этап", style: .done, target: self, action: #selector(addStep))
		navigationItem.rightBarButtonItem = b
	}
	
	@objc private func addStep() {
		
		let alertController = UIAlertController(title: "Дата конца этапа", message: "" , preferredStyle: UIAlertController.Style.actionSheet)
		
		alertController.view.addSubview(newStepPicker)//add subview
		
		let cancelAction = UIAlertAction(title: "Дальше", style: .default) { (action) in
			
			let nameAlertController = UIAlertController(title: "Выбор имени", message: "Выберите имени", preferredStyle: .alert)
			nameAlertController.addTextField(configurationHandler: { (textField) in
			})
			let doneAction = UIAlertAction(title: "Выбор имени", style: .default, handler: { (action) in
				
				let newStepName = nameAlertController.textFields!.first!.text!
				let step = ProjectStep()
				step.endDate = self.newStepDate.timeIntervalSince1970
				step.name = newStepName
				let key = self.project.id
				let ref = Database.database().reference().child("projects").child(self.project.client.formattedEmail()).child(key)
				let di = [
					"endDate": step.endDate,
					"isEnded": false,
					"name": newStepName
					] as [String : Any]
				ref.child("steps").child("\(self.project.steps.count)").setValue(di)
				let stepson = ProjectStep.from(json: JSON(di))!
				self.project.steps.append(stepson)
				self.showAlert(title: "Готово", message: "Изменено")
				self.tableView.reloadData()
				
			})
			self.present(nameAlertController, animated: true, completion: nil)
			
			nameAlertController.addAction(doneAction)
		}
		
		//add button to action sheet
		alertController.addAction(cancelAction)
		
		let height:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
		alertController.view.addConstraint(height);
		
		self.present(alertController, animated: true, completion: nil)
	}
}

extension AdminControlViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return section == 0 ? "ИНФОРМАЦИЯ О ПРОЕКТЕ" : "ЭТАПЫ"
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch indexPath.section {
		case 0:
			let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "s")
			switch indexPath.row {
			case 0:
				cell.textLabel?.text = "Название"
				cell.detailTextLabel?.text = project.name
			case 1:
				cell.textLabel?.text = "Категория"
				cell.detailTextLabel?.text = project.type
				cell.detailTextLabel?.textColor = ProjectType(rawValue: project.type)?.color
			case 2:
				cell.textLabel?.text = "Клиент"
				cell.detailTextLabel?.text = project.client
				
			case 3:
				cell.textLabel?.text = "Даты"
				cell.detailTextLabel?.text = project.dateTitle
			case 4:
				cell.textLabel?.text = "Готовность"
				cell.detailTextLabel?.text = "\(project.progress)% (доступно: \(100 - project.progress)%"
			default: break
			}
			
			return cell
		default:
			let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "s")
			let step = project.steps[indexPath.row]
			cell.textLabel?.text = step.name
			cell.detailTextLabel?.text = step.isEnded ? "Закончен" : "В работе"
			return cell
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.section {
		case 0:
			break
		default:
//			let step = project.steps[indexPath.row]
			showAlertWithActions(title: "Этап", message: "Выберите действие", withCancelButton: true, buttons: [
				(title: "Закрыть", action: {
					let stepsRef = Database.database().reference().child("projects").child(self.project.client.formattedEmail()).child(self.project.id).child("steps").child("\(indexPath.row)")
					stepsRef.observeSingleEvent(of: .value, with: { (snapshot) in
						if let array = snapshot.value as? [String: Any] {
							var b = array
							b["isEnded"] = true
							stepsRef.setValue(b)
							self.project.steps[indexPath.row].isEnded = true
							self.showAlert(title: "Готово", message: "Этап завершен")
							self.tableView.reloadData()
						}
					})
				}),
				(title: "Удалить", action: {
					let stepsRef = Database.database().reference().child("projects").child(self.project.client.formattedEmail()).child(self.project.id).child("steps")
					stepsRef.observeSingleEvent(of: .value, with: { (snapshot) in
						if let array = snapshot.value as? [[String: Any]] {
							var b = array
							b.remove(at: indexPath.row)
							stepsRef.setValue(b)
							self.project.steps.remove(at: indexPath.row)
							self.showAlert(title: "Готово", message: "Этап удален")
							self.tableView.reloadData()
						}
					})
				})
				])
		}
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0: return 5
		default: return project.steps.count
		}
	}
}
