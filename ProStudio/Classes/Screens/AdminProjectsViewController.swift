//
//  AdminProjectsViewController.swift
//  ProStudio
//
//  Created by Hadevs on 20/01/2019.
//  Copyright © 2019 Nikita. All rights reserved.
//

import UIKit

class AdminProjectsViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	
	lazy var searchController = SearchController<Project>(endedProjects + notEndedProjects)
	
	var endedProjects: [Project] = []
	var notEndedProjects: [Project] = []
	
	lazy var resultSearchController = { () -> UISearchController in
		let c = UISearchController(searchResultsController: nil)
		c.searchResultsUpdater = self
		c.dimsBackgroundDuringPresentation = false
		c.searchBar.sizeToFit()
		tableView.tableHeaderView = c.searchBar
		return c
	}()
	
	var projectSelected: ItemClosure<Project>?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		resultSearchController.dimsBackgroundDuringPresentation = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "s")
		
		ProjectManager.shared.loadAllProjects { (projects) in
			self.split(projects)
			self.searchController.items = self.endedProjects + self.notEndedProjects
			self.tableView.reloadData()
		}
	}
	
	func split(_ projects: [Project]) {
		self.endedProjects.removeAll()
		self.notEndedProjects.removeAll()
		for project in projects {
			if project.isEnded {
				self.endedProjects.append(project)
			} else {
				self.notEndedProjects.append(project)
			}
		}
	}
}

extension AdminProjectsViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		let text = searchController.searchBar.text
		let filteredProjects = self.searchController.search(by: text)
		self.split(filteredProjects)
		tableView.reloadData()
	}
}

extension AdminProjectsViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let projec: Project = {
			switch indexPath.section {
			case 0: return notEndedProjects[indexPath.row]
			default: return endedProjects[indexPath.row]
			}
		}()
		
		projectSelected?(projec)
	}
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
		case 0: return "ПРОЕКТЫ В РАБОТЕ"
		default: return "ЗАВЕРШЕННЫЕ ПРОЕКТЫ"
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let projec: Project = {
			switch indexPath.section {
			case 0: return notEndedProjects[indexPath.row]
			default: return endedProjects[indexPath.row]
			}
		}()
		let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "s")
		cell.detailTextLabel?.text = projec.client
		cell.textLabel?.text = "\(projec.name), \(projec.progress)%"
		return cell
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return notEndedProjects.count
		} else {
			return endedProjects.count
		}
	}
}
