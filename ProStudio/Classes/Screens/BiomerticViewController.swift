
import Foundation
import LocalAuthentication

import UIKit

var needToUserBiometric: Bool {
	get {
		return defaults.bool(forKey: "needToUserBiometric")
	}
	
	set {
		defaults.set(newValue, forKey: "needToUserBiometric")
		defaults.synchronize()
	}
}

class BiomerticViewController: UIViewController {
	
	@IBOutlet weak var button: UIButton!
	@IBOutlet weak var icon: UIImageView!
	@IBOutlet weak var titlelabel: UILabel!
	@IBOutlet weak var subtitlelabel: UILabel!
	
	var biometric: String {
		switch LAInteractor.shared.biometricType {
		case .faceID: return "Face ID"
		case .touchID: return "Touch ID"
		default: return ""
		}
	}
	
	
	var closed: VoidClosure?
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationController?.navigationBar.transparentNavigationBar()
		button.setTitle("ИСПОЛЬЗОВАТЬ \(biometric)", for: .normal)
		titlelabel.text = biometric
		if LAInteractor.shared.biometricType == .faceID {
			icon.image = #imageLiteral(resourceName: "Face ID.png")
		}
		
		subtitlelabel.text = "Подключите авторизацию по \(biometric), чтобы не вводить код доступ"
		navigationController?.setNavigationBarHidden(false, animated: true)
		addLeftButton()
		
	}
	
	private func addLeftButton() {
		let button = UIButton(type: .system)
		let imageInset: CGFloat = 9
		button.imageEdgeInsets = UIEdgeInsets(top: imageInset, left: -imageInset, bottom: imageInset, right: -imageInset)
		button.hero.id = "Закрыть"
		button.titleEdgeInsets = UIEdgeInsets(top: 10, left: -12, bottom: 10, right: -16)
		button.imageView?.contentMode = .scaleAspectFit
		button.setTitleColor(PSColor.cerulean, for: .normal)
		button.setTitle("Закрыть", for: .normal)
		button.titleLabel?.font = PSFont.introBold.with(size: 15)
		button.addTarget(self, action: #selector(leftButtonClicked), for: .touchUpInside)
		navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
	}
	
	@objc private func leftButtonClicked() {
		smartBack()
		closed?()
	}
	
	
	
	@IBAction func buttonclicked() {
		needToUserBiometric = true
		smartBack()
		closed?()
	}
	
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destination.
	// Pass the selected object to the new view controller.
	}
	*/
	
}


class LAInteractor {
	static let shared = LAInteractor()
	let context = LAContext()
	
	var biometricType: LABiometryType {
		get {
			var error: NSError?
			guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
				print(error?.localizedDescription ?? "")
				return .none
			}
			
			if #available(iOS 11.0, *) {
				return context.biometryType
			} else {
				return .touchID
			}
		}
	}
	
	var canRequest: Bool {
		return biometricType != .none
	}
	
	@discardableResult
	func request(with completion: @escaping ItemClosure<Bool>) -> Error? {
		var error: NSError?
		if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
			let reason = "Authenticate with Biometrics"
			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, error) in
				completion(success)
			}
		} else {
			completion(false)
		}
		
		return error
	}
}
