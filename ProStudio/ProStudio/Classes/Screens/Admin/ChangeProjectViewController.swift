//
//  ChangeProjectViewController.swift
//  ProStudio
//
//  Created by Hadevs on 03/12/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit
import Firebase


class ChangeProjectViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
	
	var projectId: String!
	var stepsCount: Int!
	var emailId: String!
	
	let percents: [Int] = (0...100).map{$0}
	var steps: [Int] {
		return (1...stepsCount).map{$0}
	}
	@IBOutlet weak var allProgressPickerView: UIPickerView!
	@IBOutlet weak var stepPickerView: UIPickerView!
	
	var allPercent = 0
	var step = 1
	var stepPercent = 0
	override func viewDidLoad() {
		super.viewDidLoad()
		
		allProgressPickerView.delegate = self
		allProgressPickerView.dataSource = self
		stepPickerView.delegate = self
		stepPickerView.dataSource = self
	}
	
	var newStepPicker = UIDatePicker(frame: .zero)
	
	var newStepDate: Date {
		return newStepPicker.date
	}
	
	@IBAction func addStep() {
		
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
				let key = String(describing: self.projectId.components(separatedBy: ":|id: ")[1])
				let ref = Database.database().reference().child("projects").child(self.emailId).child(key)
		
				ref.child("steps").child("\(self.steps.count)").setValue([
					"endDate": step.endDate,
					"isEnded": false,
					"name": newStepName
				])
				self.showAlert(title: "Готово", message: "Изменено")
				
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
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		switch pickerView {
		case allProgressPickerView: allPercent = percents[row]
		default:
			if component == 0 {
				step = steps[row]
			} else {
				stepPercent = percents[row]
			}
		}
	}
	
	@IBAction func changeButtonClicked() {
		let key = String(describing: projectId.components(separatedBy: ":|id: ")[1])
		let ref = Database.database().reference().child("projects").child(emailId).child(key)
		ref.child("progress").setValue(allPercent)
		ref.child("steps").child("\(step - 1)").child("isEnded").setValue(stepPercent == 100)
		ref.child("steps").child("\(step - 1)").child("percent").setValue(stepPercent )
		self.showAlert(title: "Готово", message: "Изменено")
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		view.endEditing(true)
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		switch pickerView {
		case allProgressPickerView: return "\(percents[row])"
		default:
			if component == 0 {
				return "\(steps[row])"
			} else if component == 1 {
				return "\(percents[row])"
			}
		}
		return nil
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		switch pickerView {
		case allProgressPickerView: return 1
		default: return 2
		}
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		switch pickerView {
		case allProgressPickerView: return percents.count
		default:
			if component == 0 {
				return steps.count
			} else if component == 1 {
				return percents.count
			}
		}
		return 0
	}
}

