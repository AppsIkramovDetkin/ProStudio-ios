import UIKit

class ProjectsList: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	var projects = [ProjectTask]()
	private lazy var searchController = SearchController<ProjectTask>(self.projects)
	private enum CellId: String {
		case headerView = "ProjectsListHeader"
		case projectsListLabelCell = "ProjectsListLabelCell"
		case projectTaskCell = "ProjectTaskCell"
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.backgroundColor = .white
		registerCells()
		tableView.separatorStyle = .none
		hero.isEnabled = true
		tableView.delaysContentTouches = false
	}
	
	
	private func addRefresh() {
		let control = UIRefreshControl(frame: CGRect.init(x: 0, y: 0, width: 44, height: 44))
		control.addTarget(self, action: #selector(refreshed), for: .valueChanged)
		tableView.refreshControl = control
	}
	
	@objc private func refreshed() {
		ProjectManager.shared.loadProjects { (projects) in
			self.projects = projects.map{ProjectTask.init(from: $0)}
			self.searchController = SearchController<ProjectTask>(self.projects)
			self.tableView.reloadData()
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		refreshed()
		navigationController?.setNavigationBarHidden(true, animated: true)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
}

extension ProjectsList: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return projects.count 
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 91
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CellId.projectTaskCell.rawValue, for: indexPath) as! ProjectTaskCell
		
		cell.colorsForGradient = projects[indexPath.row].project.gradientsColor
		cell.taskTitle.setText(projects[indexPath.row].taskTitle)
		cell.taskComment.setText(projects[indexPath.row].commentForTask)
		
		if projects[indexPath.row].done {
			cell.settingsCell(done: true)
		} else {
			cell.settingsCell(done: false)
		}
		
		cell.selectionStyle = .none
		cell.nowSelected = {
			let id = self.projects[indexPath.row].project.id
			let vc = ProgressListViewController()
			vc.projectIdToFocus = id
			self.navigationController?.pushViewController(vc, animated: true)
		}
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 97
	}
	
	func sort(all: Bool) {
		if all {
			projects = searchController.items
		} else {
			projects = searchController.search(by: "false")
		}
		
		self.tableView.reloadData()
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CellId.headerView.rawValue) as! ProjectsListHeader
		headerView.addProjectButton.hero.id = "right"
		headerView.progressButton.hero.id = "left"
		headerView.indexChanged = {
			index in
			self.sort(all: index == 0)
		}
		headerView.addButtonClicked = {
			let disc = ProjectDiscussion()
			self.navigationController?.pushViewController(disc, animated: true)
		}
		headerView.progressButtonClicked = {
//			let vc = ProgressListViewController()
//			vc.hero.isEnabled = true
//			//            self.definesPresentationContext = true
//			vc.modalPresentationStyle = .currentContext
//			self.navigationController?.pushViewController(vc, animated: true)
			self.smartBack()
		}
//		headerView.tintColor = UIColor.white
		
		return headerView
	}
	
	private func registerCells() {
		tableView.register(UINib.init(nibName: CellId.headerView.rawValue, bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: CellId.headerView.rawValue)
		tableView.register(UINib(nibName: CellId.projectTaskCell.rawValue, bundle: nil), forCellReuseIdentifier: CellId.projectTaskCell.rawValue)
	}
}


protocol Searchable {
	var parameter: String { get }
}

class SearchController<T: Searchable> {
	var items: [T]
	private var caseSensitive: Bool
	
	init(_ items: [T], caseSensitive: Bool = false) {
		self.items = items
		self.caseSensitive = caseSensitive
	}
	
	func search(by text: String?) -> [T] {
		guard !(text?.isEmpty ?? true) else {
			return items
		}
		return self.items.filter({ (item) -> Bool in
			if caseSensitive {
				return item.parameter.contains(text ?? "")
			} else {
				return item.parameter.lowercased().contains((text ?? "").lowercased())
			}
		})
	}
}
