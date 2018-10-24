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
		
		getTasks()
		registerCells()
		tableView.separatorStyle = .none
	}

	func getTasks() {
		let taskOne = ProjectTask(taskTitle: "Разработка сайта Prostudio", commentForTask: "С 22 июля по 8 августа", done: false)
		let taskTwo = ProjectTask(taskTitle: "Разработка сайта Prostudio", commentForTask: "С 22 июля по 8 августа", done: false)
		let taskThree = ProjectTask(taskTitle: "Разработка сайта Prostudio", commentForTask: "С 22 июля по 8 августа", done: true)
		let taskFour = ProjectTask(taskTitle: "Разработка сайта Prostudio", commentForTask: "С 22 июля по 8 августа", done: true)
		let taskFive = ProjectTask(taskTitle: "Разработка сайта Prostudio", commentForTask: "С 22 июля по 8 августа", done: true)
		projects = [taskOne, taskTwo, taskThree, taskFour, taskFive]
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
		
		cell.taskTitle.text = projects[indexPath.row].taskTitle
		cell.taskComment.text = projects[indexPath.row].commentForTask
		
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

		headerView.tintColor = UIColor.white
		
		return headerView
	}
	
	private func registerCells() {
		tableView.register(UINib.init(nibName: CellId.headerView.rawValue, bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: CellId.headerView.rawValue)
		tableView.register(UINib(nibName: CellId.projectTaskCell.rawValue, bundle: nil), forCellReuseIdentifier: CellId.projectTaskCell.rawValue)
	}
}
