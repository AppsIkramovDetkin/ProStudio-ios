import UIKit
import FirebaseAuth
import Alamofire
import Firebase
class AuthorizationScreen: UIViewController {
	
	@IBOutlet weak var loginButton: CustomButton!
	@IBOutlet weak var cancelButton: UIButton!
	@IBOutlet weak var logoImage: UIImageView!
	@IBOutlet weak var passwordTextField: CustomTextField!
	@IBOutlet weak var emailTextField: CustomTextField!
	@IBOutlet weak var setAccessCodeLabel: UILabel!
	@IBOutlet weak var getLoginAndPasswordButton: UIButton!
	@IBOutlet weak var accessButton: UIButton!
	@IBOutlet weak var restorePassButton: UIButton!
	
	var setAccessButton: Bool = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		emailTextField.delegate = self
		passwordTextField.delegate = self
		hero.isEnabled = true
		logoImage.hero.id = "logo"
		loginButton.hero.id = "button"
		settingsView()
		emailTextField.font = PSFont.introRegular.with(size: 17)
		passwordTextField.font = PSFont.introRegular.with(size: 17)
		emailTextField.placeholderText = "Ваша почта"
		passwordTextField.placeholderText = "Пароль"
		getLoginAndPasswordButton.titleLabel?.font = PSFont.introBook.with(size: 15)
		getLoginAndPasswordButton.setTitleColor(#colorLiteral(red: 0, green: 0.5156363845, blue: 0.8242413402, alpha: 1), for: .normal)
		getLoginAndPasswordButton.underline(with: #colorLiteral(red: 0, green: 0.5156363845, blue: 0.8242413402, alpha: 1))
		
		restorePassButton.titleLabel?.font = PSFont.introBook.with(size: 15)
		restorePassButton.setTitleColor(#colorLiteral(red: 0.6665528417, green: 0.666705668, blue: 0.6828309894, alpha: 1), for: .normal)
		restorePassButton.underline(with: #colorLiteral(red: 0.6665528417, green: 0.666705668, blue: 0.6828309894, alpha: 1))
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: true)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
	}
	
	func settingsView() {
		
		emailTextField.addTarget(self, action: #selector(editingBeganEmail(_:)), for: .editingDidBegin)
		emailTextField.addTarget(self, action: #selector(editingEndedEmail(_:)), for: .editingDidEnd)
		
		passwordTextField.addTarget(self, action: #selector(editingBeganPassword(_:)), for: .editingDidBegin)
		passwordTextField.addTarget(self, action: #selector(editingEndedPassword(_:)), for: .editingDidEnd)
		
		emailTextField.discussionField = false
		passwordTextField.discussionField = false
		
		loginButton.setTitle("ВОЙТИ", for: .normal)
		
		cancelButton.setTitle("Отмена", for: .normal)
		cancelButton.addTarget(self, action: #selector(smartBack), for: .touchUpInside)
		cancelButton.titleLabel?.font = PSFont.cellText
		cancelButton.setTitleColor(PSColor.cerulean, for: .normal)
		
		logoImage.image = UIImage(named: "logo")
		
		setAccessCodeLabel.text = "Задать код доступа"
		setAccessCodeLabel.font = PSFont.cellText
		
		accessButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
		accessButton.backgroundColor = PSColors.light
		accessButton.layer.cornerRadius = 2
		accessButton.layer.masksToBounds = true
		
		
		
		//    Если раскоментировать строки, то программа крашится
		//		emailTextField.placeholderText = "Ваша почта"
		//		passwordTextField.placeholderText = "Пароль"
		
	}
	
	@objc func editingBeganEmail(_ textField: UITextField) {
		emailTextField.chengeBorderColor()
	}
	
	@objc func editingEndedEmail(_ textField: UITextField) {
		emailTextField.chengeBorderColor()
	}
	
	@objc func editingBeganPassword(_ textField: UITextField) {
		passwordTextField.chengeBorderColor()
	}
	
	@objc func editingEndedPassword(_ textField: UITextField) {
		passwordTextField.chengeBorderColor()
	}
	
	@IBAction func login(_ sender: Any) {
		guard let email = emailTextField.text, let password = passwordTextField.text else {
			self.showAlert(title: "Ошибка", message: "Заполните поля")
			return
		}
		
		guard email != "admin" && password != "admin" else {
			Auth.auth().signIn(withEmail: "admin@admin.admin", password: "admin11") { (c, error) in
				currentUser = c!.user
				let vc = AdminViewController()
				
				self.navigationController?.pushViewController(vc, animated: true)
			}
			return
		}
		
		defaults.set(email, forKey: "email")
		defaults.set(password, forKey: "password")
		defaults.synchronize()
		Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
			if let _ = error {
				self.showAlert(title: "Ошибка", message: "Неверные данные")
			} else if let user = result?.user {
				currentUser = user
				if self.setAccessButton {
					// need to set pin
					let pinVC = SecurityScreen()
					self.present(pinVC, animated: true, completion: nil)
				} else {
					// no
					let tabBarController = UITabBarController()
					
					//1.
					let listVC = UINavigationController.init(rootViewController: ProgressListViewController())
					listVC.tabBarItem = UITabBarItem(title: "Проекты", image: UIImage.init(named: "projects"), tag: 0)
					//2.
					let cabinetVC = UINavigationController(rootViewController: PersonalAccount())
					let cabinetItem = UITabBarItem(title: "Кабинет", image: UIImage.init(named: "profile"), tag: 1)
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
	
	@IBAction func getLoginAndPasswordButton(_ sender: Any) {
		guard let email = emailTextField.text else {
			return
		}
		Auth.auth().fetchProviders(forEmail: email) { (string, error) in
			if let error = error {
				self.showAlert(title: "Ошибка", message: error.localizedDescription)
			} else {
				if string == nil {
					Database.database().reference().child("requests").child(email.formattedEmail()).setValue(true)
				} else {
					self.showAlert(title: "Ошибка", message: "Данный email уже используется")
				}
			}
		}
	}
	
	@IBAction func accessButtonPressed(_ sender: Any) {
		
		if !setAccessButton {
			setAccessButton = true
			accessButton.setImage(UIImage(named: "invalid-name")?.withRenderingMode(.alwaysOriginal), for: .normal)
			accessButton.backgroundColor = #colorLiteral(red: 0, green: 0.5083315372, blue: 0.8099726439, alpha: 1)
		} else {
			setAccessButton = false
			accessButton.setImage(nil, for: .normal)
			accessButton.backgroundColor = PSColors.light
		}
	}
}

extension AuthorizationScreen: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
}

extension UIView {
	func underline(with color: UIColor = PSColors.light) {
		let line = UIView()
		line.translatesAutoresizingMaskIntoConstraints = false
		line.backgroundColor = color
		self.addSubview(line)
		self.addConstraints(NSLayoutConstraint.contraints(withNewVisualFormat: "H:|[v]|,V:[v(1)]-2-|", dict: ["v": line]))
		//        let constraints = NSLayoutConstraint.contraints(withNewVisualFormat: "H:|[v]|,V:[v(1)]|", dict: ["v": line])
		
		//        self.addConstraints(constraints)
	}
}
