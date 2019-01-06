//
//  ChatsViewController.swift
//  ProStudio
//
//  Created by Hadevs on 06/01/2019.
//  Copyright © 2019 Nikita. All rights reserved.
//

import UIKit
import Firebase

class ChatsViewController: UITableViewController {
	
	var ids: [String] = [] {
		didSet {
			tableView.reloadData()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		Database.database().reference().child("chats").observe(.value) { (snapshot) in
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
		let vc = ChatWithManager()
		vc.userId = ids[indexPath.row]
		navigationController?.pushViewController(vc, animated: true)
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return ids.count
	}
	
}
