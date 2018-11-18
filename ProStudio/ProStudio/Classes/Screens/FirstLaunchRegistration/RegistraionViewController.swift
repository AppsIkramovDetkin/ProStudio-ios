import UIKit
import Hero
import Firebase

class RegistraionViewController: UIViewController {
	
	@IBOutlet weak var loginButton: PSButton!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var bottomLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		NavigationBarDecorator.decorate(self)
		hero.isEnabled = true
		loginButton.touched = {
			let vc = AuthorizationScreen()
			self.present(vc, animated: true, completion: nil)
		}
        hero.isEnabled = true
        logoImage.hero.id = "logo"
        loginButton.hero.id = "button"
		addLeftButton()
		addRightButton()
		UIApplication.shared.statusBarStyle = .lightContent
//        descLabel.setLineSpacing(lineSpacing: 8)
        descLabel.text = "Для доступа к своим проектам\nвойдите с помошью логина и пароля."
        descLabel.textAlignment = .center
//        bottomLabel.setLineSpacing(lineSpacing: 0.14, lineHeightMultiple: 20)
        if let _ = defaults.string(forKey: "pin") {
            let vc = SecurityScreen()
            vc.isRegister = false
            self.present(vc, animated: true, completion: nil)
        } else {
            if let email = defaults.string(forKey: "email"), let password = defaults.string(forKey: "password") {
                Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    if let user = result?.user {
                        currentUser = user
                        // no
                        let tabBarController = UITabBarController()
                        
                        //1.
                        let listVC = ProjectsList()
                        listVC.tabBarItem = UITabBarItem(title: "Проекты", image: UIImage.init(named: "projects"), tag: 0)
                        //2.
                        let cabinetVC = PersonalAccount()
                        let cabinetItem = UITabBarItem(title: "Кабинет", image: UIImage.init(named: "contacts"), tag: 1)
                        let inset3: CGFloat = 0
                        cabinetItem.imageInsets = UIEdgeInsets(top: inset3, left: inset3, bottom: inset3, right: inset3)
                        cabinetVC.tabBarItem = cabinetItem
                        
                        //3.
                        let chatVC = UINavigationController(rootViewController: ChatWithManager())
                        let chatItem = UITabBarItem(title: "Поддержка", image: UIImage.init(named: "support"), tag: 2)
                        chatItem.imageInsets = UIEdgeInsets(top: inset3, left: inset3, bottom: inset3, right: inset3)
                        chatVC.tabBarItem = chatItem
                        //4.
                        let contactsVC = UINavigationController(rootViewController: ContactsViewController())
                        let contactsTabItem = UITabBarItem(title: "Контакты", image: UIImage.init(named: "contacts"), tag: 0)
                        let inset2: CGFloat = 0
                        contactsTabItem.imageInsets = UIEdgeInsets(top: inset2, left: inset2, bottom: inset2, right: inset2)
                        
                        contactsVC.tabBarItem = contactsTabItem
                        
                        tabBarController.tabBar.tintColor = PSColor.cerulean
                        tabBarController.tabBar.unselectedItemTintColor = PSColor.coolGrey
                        tabBarController.setViewControllers([listVC, chatVC, cabinetVC, contactsVC], animated: true)
                        self.present(tabBarController, animated: true, completion: nil)
                    }
                }
            }
        }
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	private func addRightButton() {
		let button = UIButton(type: .system)
		let imageInset: CGFloat = 6
		button.imageEdgeInsets = UIEdgeInsets(top: imageInset, left: -imageInset, bottom: imageInset, right: -imageInset)
		button.titleEdgeInsets = UIEdgeInsets(top: 10, left: -13, bottom: 10, right: -19)
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
extension UILabel {
    
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
}
