//
//  CreateProjectViewController.swift
//  ProStudio
//
//  Created by Hadevs on 02/12/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CreateProjectViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
	
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var startDatePicker: UIDatePicker!
	@IBOutlet weak var endDatePickert: UIDatePicker!
	@IBOutlet weak var countOfStepsLabel: UILabel!
	@IBOutlet weak var typesPickerView: UIPickerView!
	
	var email: String {
		return emailTextField.text ?? ""
	}
	
	var startDate: Date {
		return startDatePicker.date
	}
	
	var endDate: Date {
		return endDatePickert.date
	}
	var projectName: String {
		return nameTextField.text ?? ""
	}
	var type: ProjectType = .branding
	var steps: [ProjectStep] = []
	let allTypes: [ProjectType] = [.branding, .appsAndSites, .analytics, .seo]
	
  override func viewDidLoad() {
    super.viewDidLoad()
		
    typesPickerView.delegate = self
		typesPickerView.dataSource = self
  }
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return allTypes[row].rawValue
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		type = allTypes[row]
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return allTypes.count
	}
	
	@IBAction func addStepClickked() {
		addStep()
	}
	
	@IBAction func removeStepClicked() {
		guard !steps.isEmpty else {
			return
		}
		
		steps.removeLast()
		self.countOfStepsLabel.text = "Количество шагов: \(self.steps.count)"
	}
	
	@IBAction func doneClicked() {
		guard !email.isEmpty && !projectName.isEmpty && !steps.isEmpty else {
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
		let dict = [
			"id": id,
			"client": self.email,
			"type": self.type.rawValue,
			"startDate": self.startDate.timeIntervalSince1970,
			"endDate": self.endDate.timeIntervalSince1970,
			"name": self.projectName,
			"isEnded": false,
			"progress": 0,
			"steps": steps.map{["name": $0.name, "isEnded": true, "endDate": $0.endDate]}
			] as [String : Any]
		
		ref.child("projects").child(email.formattedEmail()).child(id).setValue(dict)
		self.showAlertWithOneAction(title: "Готово", message: "Проект создан") {
			self.navigationController?.popViewController(animated: true)
		}
	}
	
	var newStepPicker = UIDatePicker(frame: .zero)
	
	var newStepDate: Date {
		return newStepPicker.date
	}
	var newStepName = ""
  func addStep() {
		newStepPicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 260))
		
    newStepPicker.datePickerMode = UIDatePicker.Mode.date
  
    let alertController = UIAlertController(title: "Дата конца этапа", message: "" , preferredStyle: UIAlertController.Style.actionSheet)
    
    alertController.view.addSubview(newStepPicker)//add subview
		
		let cancelAction = UIAlertAction(title: "Дальше", style: .default) { (action) in
			
			let nameAlertController = UIAlertController(title: "Выбор имени", message: "Выберите имени", preferredStyle: .alert)
			nameAlertController.addTextField(configurationHandler: { (textField) in
			})
			let doneAction = UIAlertAction(title: "Выбор имени", style: .default, handler: { (action) in
				
				self.newStepName = nameAlertController.textFields!.first!.text!
				let step = ProjectStep()
				step.endDate = self.newStepDate.timeIntervalSince1970
				step.name = self.newStepName
				self.steps.append(step)
				self.countOfStepsLabel.text = "Количество шагов: \(self.steps.count)"
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
