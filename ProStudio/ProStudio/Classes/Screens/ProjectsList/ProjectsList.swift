import UIKit

class ProjectsList: UIViewController {

	@IBOutlet weak var tableView: UITableView!

	var projects = [ProjectTask]()
	
	private enum CellId: String {
		case headerView = "ProjectsListHeader"
		case projectsListLabelCell = "ProjectsListLabelCell"
		case projectTaskCell = "ProjectTaskCell"
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		registerCells()
		tableView.separatorStyle = .none
		hero.isEnabled = true
        ProjectManager.shared.loadProjects { (projects) in
            self.projects = projects.map{ProjectTask.init(from: $0)}
            self.tableView.reloadData()
        }
        tableView.delaysContentTouches = false
	}
}

extension ProjectsList: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return projects.count 
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return view.frame.height * 0.1227
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
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return view.frame.size.height * 0.1578
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CellId.headerView.rawValue) as! ProjectsListHeader
		headerView.addProjectButton.hero.id = "right"
		headerView.progressButton.hero.id = "left"
		headerView.progressButtonClicked = {
			let vc = UINavigationController(rootViewController: ProgressListViewController())
			vc.hero.isEnabled = true
//            self.definesPresentationContext = true
			vc.modalPresentationStyle = .overCurrentContext
			self.present(vc, animated: true, completion: nil)
		}
		headerView.tintColor = UIColor.white
		
		return headerView
	}
	
	private func registerCells() {
		tableView.register(UINib.init(nibName: CellId.headerView.rawValue, bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: CellId.headerView.rawValue)
		tableView.register(UINib(nibName: CellId.projectTaskCell.rawValue, bundle: nil), forCellReuseIdentifier: CellId.projectTaskCell.rawValue)
	}
}
