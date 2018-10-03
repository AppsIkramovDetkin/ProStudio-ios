import UIKit

class RegistraionViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateLoginButton()
    }
    
    private func configurateLoginButton() {
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        loginButton.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        loginButton.layer.shadowColor = #colorLiteral(red: 0, green: 0.5058823529, blue: 0.8, alpha: 1)
        loginButton.layer.shadowOpacity = 0.57
        loginButton.layer.shadowRadius = 7.0
    }
}
