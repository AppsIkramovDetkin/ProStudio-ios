import UIKit

class AuthorizationScreen: UIViewController {
	
	@IBOutlet weak var loginButton: CustomButton!
	@IBOutlet weak var cancelButton: UIButton!
	@IBOutlet weak var logoImage: UIImageView!
	@IBOutlet weak var passwordTextField: CustomTextField!
	@IBOutlet weak var emailTextField: CustomTextField!
	@IBOutlet weak var setAccessCodeLabel: UILabel!
	@IBOutlet weak var getLoginAndPasswordButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()

		emailTextField.delegate = self
		passwordTextField.delegate = self

		settingsView()
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
	}
	
	func settingsView() {
		
		loginButton.setTitle("ВОЙТИ", for: .normal)
		
		cancelButton.setTitle("Отмена", for: .normal)
		cancelButton.titleLabel?.font = PSFont.cellText
		cancelButton.setTitleColor(PSColor.cerulean, for: .normal)
		
		logoImage.image = UIImage(named: "logo")
		
		setAccessCodeLabel.text = "Задать код доступа"
		setAccessCodeLabel.font = PSFont.cellText
		
//		emailTextField.placeholderText = "Ваша почта"
//		passwordTextField.placeholderText = "Пароль"
		
	}
	
	func start(what: Bool) {
		
		if what {
			emailTextField.chengeBorderColor()
		} else {
			emailTextField.chengeBorderColor()
		}
	}
	
	@IBAction func login(_ sender: Any) {
		
		loginButton.action { () -> () in
			print("test")
		}
		
	}

	@IBAction func getLoginAndPasswordButton(_ sender: Any) {
		print("do smth")
	}
}

extension AuthorizationScreen: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}

	func textFieldDidBeginEditing(_ textField: UITextField) {
		start(what: true)
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		start(what: false)
	}
}
