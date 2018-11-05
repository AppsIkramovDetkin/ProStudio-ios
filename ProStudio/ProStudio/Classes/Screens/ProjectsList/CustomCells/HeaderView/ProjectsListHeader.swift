import UIKit

class ProjectsListHeader: UITableViewHeaderFooterView {

	@IBOutlet weak var projectsPicker: UISegmentedControl!
	@IBOutlet weak var progressButton: UIButton!
	@IBOutlet weak var addProjectButton: UIButton!
	@IBOutlet weak var projectsListLabel: UILabel!
	
	var progressButtonClicked: VoidClosure?
	
	override func draw(_ rect: CGRect) {
		projectsListLabel.hero.id = "title"
		progressButton.setTitle("Прогресс", for: .normal)
		progressButton.setTitleColor(PSColor.cerulean, for: .normal)
		progressButton.titleLabel?.font = PSFont.cellText
		progressButton.addTarget(self, action: #selector(progress(_:)), for: .touchUpInside)

		addProjectButton.setTitle("Добавить", for: .normal)
		addProjectButton.titleLabel?.font = PSFont.cellText
		addProjectButton.setTitleColor(PSColor.cerulean, for: .normal)
		addProjectButton.addTarget(self, action: #selector(addProject(_:)), for: .touchUpInside)

		projectsPicker.tintColor = PSColor.cerulean
		projectsPicker.layer.borderColor = PSColor.cerulean.cgColor
		projectsPicker.layer.borderWidth = 1.0
		projectsPicker.layer.cornerRadius = 15
		projectsPicker.setTitleTextAttributes([NSAttributedString.Key.font: PSFont.segmentedFont!],
																						for: .normal)
		projectsPicker.clipsToBounds = true
		
	}
	
	@objc func progress(_ sender: UIButton) {
		progressButtonClicked?()
	}
	
	@objc func addProject(_ sender: UIButton) {
		print("add smth")
	}
	
	
}
