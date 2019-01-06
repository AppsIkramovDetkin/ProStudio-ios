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
		
		registerCells()
		tableView.separatorStyle = .none
		hero.isEnabled = true
        ProjectManager.shared.loadProjects { (projects) in
            self.projects = projects.map{ProjectTask.init(from: $0)}
            self.searchController = SearchController<ProjectTask>(self.projects)
            self.tableView.reloadData()
        }
        tableView.delaysContentTouches = false
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: true)
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
		headerView.progressButtonClicked = {
			let vc = ProgressListViewController()
			vc.hero.isEnabled = true
//            self.definesPresentationContext = true
			vc.modalPresentationStyle = .currentContext
			self.navigationController?.pushViewController(vc, animated: true)
		}
		headerView.tintColor = UIColor.white
		
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
    private(set) var items: [T]
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
