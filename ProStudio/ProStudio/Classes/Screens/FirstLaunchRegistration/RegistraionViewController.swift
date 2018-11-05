import UIKit
import Hero
class RegistraionViewController: UIViewController {
	
	@IBOutlet weak var loginButton: PSButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		NavigationBarDecorator.decorate(self)
		hero.isEnabled = true
		loginButton.touched = {
			let vc = SecurityScreen()
			self.present(vc, animated: true, completion: nil)
		}
		addLeftButton()
		addRightButton()
		UIApplication.shared.statusBarStyle = .lightContent
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	private func addRightButton() {
		let button = UIButton(type: .system)
		let imageInset: CGFloat = 6
		button.imageEdgeInsets = UIEdgeInsets(top: imageInset, left: -imageInset, bottom: imageInset, right: -imageInset)
		button.titleEdgeInsets = UIEdgeInsets(top: 10, left: -12, bottom: 10, right: -16)
		button.setImage(UIImage(named: "eye")!, for: .normal)
		button.imageView?.contentMode = .scaleAspectFit
		button.semanticContentAttribute = .forceRightToLeft
		button.setTitleColor(.white, for: .normal)
		button.setTitle("ДЕМО", for: .normal)
		button.titleLabel?.font = PSFont.introBold.with(size: 10.0)
		navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: button)]
	}
	
	private func addLeftButton() {
		let button = UIButton(type: .system)
		let imageInset: CGFloat = 9
		button.imageEdgeInsets = UIEdgeInsets(top: imageInset, left: -imageInset, bottom: imageInset, right: -imageInset)
		button.titleEdgeInsets = UIEdgeInsets(top: 10, left: -12, bottom: 10, right: -16)
		button.setImage(UIImage(named: "phone")!, for: .normal)
		button.imageView?.contentMode = .scaleAspectFit
		button.setTitleColor(.white, for: .normal)
		button.setTitle("ПОЗВОНИТЬ", for: .normal)
		button.titleLabel?.font = PSFont.introBold.with(size: 10.0)
		navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
	}
	
}
