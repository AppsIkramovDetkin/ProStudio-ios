import UIKit

class ProjectsList: UIViewController {

	@IBOutlet weak var tableView: UITableView!

	var projects = [ProjectTask]()
	
	private enum CellId: String {
		case headerView = "ProjectsListHeader"
		case projectsListLabelCell = "ProjectsListLabelCell"
		case projectTaskCell = "ProjectTaskCell"
	}
	
	var colors: [[UIColor]] = [
		[UIColor(netHex: 0x3f8cc1), UIColor(netHex: 0x3bb2c2)],
		[UIColor.init(netHex: 0xf7c100), UIColor.init(netHex: 0xdb2249)],
		[UIColor.init(netHex: 0xdb2149), UIColor.init(netHex: 0x8f1c77)],
		[UIColor.init(netHex: 0x8d1d77), UIColor.init(netHex: 0x0066ad)],
		[UIColor.init(netHex: 0x0067ad), UIColor.init(netHex: 0x3ab1c2)]
	]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		getTasks()
		registerCells()
		tableView.separatorStyle = .none
		hero.isEnabled = true
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
		
		cell.colorsForGradient = colors[indexPath.row]
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
			self.definesPresentationContext = true
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
