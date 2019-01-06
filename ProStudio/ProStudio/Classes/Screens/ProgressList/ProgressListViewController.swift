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
		self.setBackgroundImage(UIImage(), for: .default)
		self.shadowImage = UIImage()
		self.isTranslucent = true
	}
}

class ProgressListViewController: UIViewController, UIScrollViewDelegate {
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var indexLabel: UILabel!
	var projects: [Project] = []
	var currentSteps: [ProjectStep] = []
	override func viewDidLoad() {
		super.viewDidLoad()
		scrollView.delegate = self
		tableView.delegate = self
		tableView.dataSource = self
		
		tableView.register(ProjectStepTableViewCell.nib, forCellReuseIdentifier: "ProjectStepTableViewCell")
		
		hero.isEnabled = true
		titleLabel.hero.id = "title"
		
		tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 15000, bottom: 0, right: 0)
		addRightButton()
		navigationController?.navigationBar.transparentNavigationBar()
		addLeftButton()
		ProjectManager.shared.loadProjects { (projects) in
			let views = projects.enumerated().map({ (i, project) -> PSCircularView in
				let view = PSCircularView(project: project)
				view.tag = i
				view.animate(with: CGFloat(project.progress)/100, duration: 1.5 * (TimeInterval(i) + 1))
				return view
			})
			if !projects.isEmpty {
				self.currentSteps = projects[0].steps
				self.indexLabel.text = "1 из \(projects.count)"
			} else {
				self.indexLabel.text = "Проектов нет"
			}
			
			self.setupscrollView(slides: views)
			self.projects = projects
			self.tableView.reloadData()
		}
		// Do any additional setup after loading the view.
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: true)
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
		button.titleLabel?.font = PSFont.introBold.with(size: 16)
		navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: button)]
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
		button.titleLabel?.font = PSFont.introBold.with(size: 16)
		button.addTarget(self, action: #selector(leftButtonClicked), for: .touchUpInside)
		navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
	}
	
	@objc private func leftButtonClicked() {
		smartBack()
	}
	
	func setupscrollView(slides: [UIView]) {
		scrollView.showsHorizontalScrollIndicator = false
		let spacing: CGFloat = 48
		scrollView.contentInset = UIEdgeInsets(top: 0, left: 48, bottom: 0, right: 48)
		for i in 0..<slides.count {
			let slide = slides[i]
			
			slide.translatesAutoresizingMaskIntoConstraints = false
			scrollView.addSubview(slide)
			scrollView.addConstraints(NSLayoutConstraint.contraints(withNewVisualFormat: "V:|[slide]|", dict: ["slide": slide]) + [NSLayoutConstraint.init(item: slide, attribute: .width, relatedBy: .equal, toItem: slide.superview, attribute: .width, multiplier: 0.65, constant: 0)] + [NSLayoutConstraint.quadroAspect(on: slide)])
			if slides.contains(index: i - 1) {
				let prevSlide = slides[i - 1]
				if i == slides.count - 1 {
					scrollView.addConstraints(NSLayoutConstraint.contraints(withNewVisualFormat: "H:[prevSlide]-\(spacing)-[slide]|", dict: ["prevSlide": prevSlide,"slide": slide]))
				} else {
					scrollView.addConstraints(NSLayoutConstraint.contraints(withNewVisualFormat: "H:[prevSlide]-\(spacing)-[slide]", dict: ["prevSlide": prevSlide,"slide": slide]))
				}
			} else {
				scrollView.addConstraints(NSLayoutConstraint.contraints(withNewVisualFormat: "H:|[slide]", dict: ["slide": slide]))
			}
		}
		
		self.scrollView.contentSize = CGSize(width: view.frame.size.width * CGFloat(slides.count), height: scrollView.frame.height)
	}
	
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		guard scrollView == self.scrollView else {
			return
		}
		let maxView = scrollView.subviews.sorted { (view1, view2) -> Bool in
			return (view1.visibleRect ?? .zero).width > (view2.visibleRect ?? .zero).width
			}.first
		
		guard let v = maxView else {
			return
		}
		
		guard projects.contains(index: v.tag) else {
			return
		}
		
		self.indexLabel.text = "\(v.tag + 1) из \(self.projects.count)"
		let project = projects[v.tag]
		self.currentSteps = project.steps
		self.tableView.reloadData()
	}
	
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		guard scrollView == self.scrollView else {
			return
		}
		let maxView = scrollView.subviews.sorted { (view1, view2) -> Bool in
			return (view1.visibleRect ?? .zero).width > (view2.visibleRect ?? .zero).width
			}.first
		
		guard let v = maxView else {
			return
		}
		self.indexLabel.text = "\(v.tag + 1) из \(self.projects.count)"
		scrollView.setContentOffset(CGPoint.init(x: v.center.x - scrollView.frame.width / 2, y: scrollView.contentOffset.y), animated: true)
	}
}

extension ProgressListViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectStepTableViewCell", for: indexPath) as! ProjectStepTableViewCell
		let step = currentSteps[indexPath.row]
		
		if !step.isEnded {
			cell.leftIconView.image = UIImage(named: "time")
			cell.rightLabel.textColor = PSColor.cerulean
		} else {
			cell.leftIconView.image = UIImage(named: "checkmark")
			cell.rightLabel.textColor = PSColor.coolGrey
		}
		cell.titleLabel.text = step.name
		cell.rightLabel.text = step.formattedDate()
		cell.separatorInset = .zero
		cell.selectionStyle = .none
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 75
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
