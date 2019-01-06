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
		let ref = Database.database().reference().child("projects").child(emailId).child(projectId)
		ref.child("progress").setValue(allPercent)
//		ref.child("steps").child("\(step - 1)").child(<#T##pathString: String##String#>)
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
	
//	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//		switch pickerView {
//		case allProgressPickerView:
//
//		default:
//			if component == 0 {
//				return "\(steps[row])"
//			} else if component == 1 {
//				return "\(percents[row])"
//			}
//		}
//		return nil
//	}
}

