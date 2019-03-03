//
//  ProgressListViewController.swift
//  ProStudio
//
//  Created by Danil Detkin on 04/11/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit
extension UINavigationBar {
	func transparentNavigationBar() {
	}
	
	func noTransparent() {
//		self.setBackgroundImage(?nil, for: .default)
//		self.shadowImage = nil
		
	}
}

class ProgressListViewController: UIViewController, UIScrollViewDelegate {
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var titleLabel: SpacedLabel!
	@IBOutlet weak var pageContainerView: UIView!
	@IBOutlet weak var indexLabel: UILabel!
	var allViewControllers: [UIViewController] = []
	var projectIdToFocus: String?
	var projects: [Project] = []
	var currentSteps: [ProjectStep] = []
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
		
		tableView.register(ProjectStepTableViewCell.nib, forCellReuseIdentifier: "ProjectStepTableViewCell")
		
		hero.isEnabled = true
		titleLabel.hero.id = "title"
		titleLabel.font = PSFont.introBold.with(size: 34)
		
		tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 15000, bottom: 0, right: 0)
		addRightButton()
		
		addLeftButton()
		ProjectManager.shared.loadProjects { (projects) in
			let newProjects = projects.sorted(by: { (p1, p2) -> Bool in
				return !p1.isEnded
			})
			
			let views = newProjects.enumerated().map({ (i, project) -> PSCircularView in
				let view = PSCircularView(project: project)
				view.clipsToBounds = false
				view.backgroundColor = .white
				view.tag = i
				view.label.textColor = project.getType()?.color
				view.checkmark.tintColor = project.getType()?.color
				view.checkmark.isHidden = !project.isEnded
				view.animate(with: CGFloat(project.progress)/100, duration: 1.5 * (TimeInterval(i) + 1))
				return view
			})
			
			
			if !newProjects.isEmpty {
				self.currentSteps = newProjects[0].steps
				self.titleLabel.set(text: newProjects[0].name.capitalized, with: 10)
				self.indexLabel.text = "1 из \(newProjects.count)"
			} else {
				self.indexLabel.text = "Проектов нет"
			}
			
			
			self.setupscrollView(controllers: views.map { sview in
				let vc = UIViewController()
				sview.translatesAutoresizingMaskIntoConstraints = false
				sview.clipsToBounds = false
				vc.view.addSubview(sview)
				let margin: CGFloat = 16//16
				vc.view.addConstraints(NSLayoutConstraint.contraints(withNewVisualFormat: "H:|-\(margin)-[sview]-\(margin)-|,V:|-\(margin)-[sview]-\(margin)-|", dict: ["sview": sview]))
				return vc
			})
//			self.scrollViewHeight.constant = self.scrollView.contentSize.height
			
			self.tableView.reloadData()
			self.projects = newProjects
			if let id = self.projectIdToFocus {
				self.scroll(to: id)
			} else {
				if let id = newProjects.first?.id {
					self.projectIdToFocus = id
					self.scroll(to: id)
				}
			}
//			self.scrollView.setContentOffset(.zero, animated: true)
//			self.scrollViewDidEndDragging(self.scrollView, willDecelerate: false)
		}
		// Do any additional setup after loading the view.
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationItem.title = "Проекты"
		title = "Проекты"
		navigationItem.titleView = nil
		navigationController?.navigationBar.transparentNavigationBar()
		navigationController?.navigationBar.barTintColor = .white
		navigationController?.navigationBar.shadowImage = UIImage()
		navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
		navigationItem.largeTitleDisplayMode = .never
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationController?.navigationBar.barStyle = .default
		navigationController?.navigationBar.transparentNavigationBar()
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
	
	func setupscrollView(controllers: [UIViewController]) {
		allViewControllers = controllers
		pageController.view.translatesAutoresizingMaskIntoConstraints = false
		pageController.delegate = self
		
		pageController.dataSource = self
		
		pageContainerView.addSubview(pageController.view)
		let margin: CGFloat = 0//16
		pageContainerView.addConstraints(NSLayoutConstraint.contraints(withNewVisualFormat: "H:|-\(margin)-[sview]-\(margin)-|,V:|-\(margin)-[sview]-\(margin)-|", dict: ["sview": pageController.view]))
		
		pageController.setViewControllers([controllers.first!], direction: .forward, animated: true, completion: nil)
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .default
	}
	
	private func addRightButton() {
		let button = UIButton(type: .system)
		let imageInset: CGFloat = 6
		button.imageEdgeInsets = UIEdgeInsets(top: imageInset, left: -imageInset, bottom: imageInset, right: -imageInset)
		button.hero.id = "right"
		button.titleEdgeInsets = UIEdgeInsets(top: 10, left: -12, bottom: 10, right: -16)
		button.imageView?.contentMode = .scaleAspectFit
		button.semanticContentAttribute = .forceRightToLeft
		button.setTitleColor(PSColor.cerulean, for: .normal)
		button.setTitle("Добавить", for: .normal)
		button.titleLabel?.font = PSFont.introRegular.with(size: 17)
		button.addTarget(self, action: #selector(add), for: .touchUpInside)
		navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: button)]
	}
	
	@objc private func add() {
		let disc = ProjectDiscussion()
		self.navigationController?.pushViewController(disc, animated: true)
	}
	
	private func addLeftButton() {
		let button = UIButton(type: .system)
		let imageInset: CGFloat = 9
		button.imageEdgeInsets = UIEdgeInsets(top: imageInset, left: -imageInset, bottom: imageInset, right: -imageInset)
		button.hero.id = "left"
		button.titleEdgeInsets = UIEdgeInsets(top: 10, left: -12, bottom: 10, right: -16)
		button.imageView?.contentMode = .scaleAspectFit
		button.setTitleColor(PSColor.cerulean, for: .normal)
		button.setTitle("Список", for: .normal)
		button.titleLabel?.font = PSFont.introRegular.with(size: 17)
		button.addTarget(self, action: #selector(leftButtonClicked), for: .touchUpInside)
		navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
	}
	
	@objc private func leftButtonClicked() {
		let vc = ProjectsList()
		navigationController?.pushViewController(vc, animated: true)
	}
	
	
	func scroll(to projectId: String) {
		let projectIndex = projects.firstIndex { (p) -> Bool in
			return p.id == projectIdToFocus
		}!
		
//		let spacing: CGFloat = (view.bounds.width - 295) / 2
//		let width = CGFloat(295 + spacing)
//		let offset = CGFloat(projectIndex) * width - spacing / 2
		
		let spacing = (view.bounds.width - 295)/2
		let offset = (view.bounds.width - spacing) * CGFloat(projectIndex) - spacing
		
	}
}

extension ProgressListViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectStepTableViewCell", for: indexPath) as! ProjectStepTableViewCell
		let step = currentSteps[indexPath.row]
		
		if !step.isEnded {
			cell.leftIconView.image = UIImage(named: "group55")
			cell.titleLabel.textColor = .black
			cell.rightLabel.textColor = PSColor.cerulean
		} else {
			cell.leftIconView.image = UIImage(named: "checka")
			cell.titleLabel.textColor = PSColor.coolGrey
			cell.rightLabel.textColor = PSColor.coolGrey
		}
		cell.titleLabel.text = step.name
		cell.rightLabel.text = step.formattedDate()
		if indexPath.row == currentSteps.count-1 {
			cell.separatorInset = .zero
		} else {
			cell.separatorInset = UIEdgeInsets(top: 9, left: 15, bottom: 0, right: 0)
		}
		cell.selectionStyle = .none
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 60
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return currentSteps.count
	}
}

extension UIView {
	var visibleRect: CGRect? {
		guard let superview = superview else { return nil }
		return frame.intersection(superview.bounds)
	}
}

extension ProgressListViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		guard let currentIndex = allViewControllers.firstIndex(of: viewController) else {
			return nil
		}
		
		return allViewControllers[safe: currentIndex + 1]
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		guard let currentIndex = allViewControllers.firstIndex(of: viewController) else {
			return nil
		}
		
		return allViewControllers[safe: currentIndex - 1]
	}
}
