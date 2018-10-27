import UIKit

class AuthorizationScreen: UIViewController {
	
	@IBOutlet weak var loginButton: CustomButton!
	@IBOutlet weak var cancelButton: UIButton!
	@IBOutlet weak var logoImage: UIImageView!
	@IBOutlet weak var passwordTextField: CustomTextField!
	@IBOutlet weak var emailTextField: CustomTextField!
	@IBOutlet weak var setAccessCodeLabel: UILabel!
	@IBOutlet weak var getLoginAndPasswordButton: UIButton!
	@IBOutlet weak var accessButton: UIButton!
	@IBOutlet weak var okImage: UIImageView!
	
	var trueOrFalse: Int = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()

		emailTextField.delegate = self
		passwordTextField.delegate = self
		
		settingsView()
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
	}

	func settingsView() {
		
		emailTextField.addTarget(self, action: #selector(editingBeganEmail(_:)), for: .editingDidBegin)
		emailTextField.addTarget(self, action: #selector(editingEndedEmail(_:)), for: .editingDidEnd)
		
		passwordTextField.addTarget(self, action: #selector(editingBeganPassword(_:)), for: .editingDidBegin)
		passwordTextField.addTarget(self, action: #selector(editingEndedPassword(_:)), for: .editingDidEnd)
		
		loginButton.setTitle("ВОЙТИ", for: .normal)
		
		cancelButton.setTitle("Отмена", for: .normal)
		cancelButton.titleLabel?.font = PSFont.cellText
		cancelButton.setTitleColor(PSColor.cerulean, for: .normal)
		
		logoImage.image = UIImage(named: "logo")
		
		setAccessCodeLabel.text = "Задать код доступа"
		setAccessCodeLabel.font = PSFont.cellText
		
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
		
		loginButton.action { () -> () in
			print("test")
		}
		
	}

	@IBAction func getLoginAndPasswordButton(_ sender: Any) {
		print("do smth")
	}
	
	@IBAction func accessButtonPressed(_ sender: Any) {
		trueOrFalse += 1
		
		if trueOrFalse % 2 != 0 {
			accessButton.backgroundColor = PSColor.cerulean
			okImage.image = UIImage(named: "invalid-name")
		} else {
			okImage.image = nil
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
