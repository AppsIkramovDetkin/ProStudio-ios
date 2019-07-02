//
//  ChangeUserViewController.swift
//  ProStudio
//
//  Created by Hadevs on 09/01/2019.
//  Copyright © 2019 Nikita. All rights reserved.
//

import UIKit
import Firebase

class ChangeUserViewController: UIViewController {
	
	@IBOutlet weak var nameField: UITextField!
	@IBOutlet weak var phoneField: UITextField!
	var name: String?
	var userId: String!
	var phone: String?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		nameField.text = name
		phoneField.text = phone
		// Do any additional setup after loading the view.
	}
	
	
	
	@IBAction func changeName() {
		guard let name = nameField.text, !name.isEmpty else {
			return
		}
		Database.database().reference().child("users").child(userId).child("name").setValue(name)
		
	}
	
	@IBAction func changePhone() {
		guard let phone = phoneField.text, !phone.isEmpty else {
			return
		}
		
		Database.database().reference().child("users").child(userId).child("phone").setValue(phone)
	}
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destination.
	// Pass the selected object to the new view controller.
	}
	*/
	
}
