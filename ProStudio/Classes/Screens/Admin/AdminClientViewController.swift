//
//  AdminClientViewController.swift
//  ProStudio
//
//  Created by Hadevs on 21/01/2019.
//  Copyright © 2019 Nikita. All rights reserved.
//

import UIKit
import Firebase

struct FullUser {
	var name: String?
	var company: String?
	var email: String?
	var dateAddUnix: TimeInterval?
}

class AdminClientViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	var userId: String!
	var fullUser: FullUser = FullUser()
	
	convenience init(userId: String) {
		self.init()
		self.userId = userId
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
		Database.database().reference().child("users").child(userId).observe(.value) { (snapshot) in
			if let dict = snapshot.value as? [String: Any] {
				let name = dict["name"] as? String
				let unix = dict["dateAddedUnix"] as? TimeInterval
				let email = dict["email"] as? String
				self.fullUser.name = name
				self.fullUser.dateAddUnix = unix
				self.fullUser.email = email
				self.tableView.reloadData()
			}
		}
	}
}

extension AdminClientViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
//		switch indexPath.row {
//		case 0:
//			cell.textLabel?.text = fullUser.name ?? "Не"
//		}
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 5
	}
}
