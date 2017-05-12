import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class LoginViewController: UIViewController, LoginView {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var presenter: LoginPresenter!
    
    var basePresenter: Presenter! {
        return presenter //To see the magic go to the salas project
    }
    
    static func initFromStoryboard() -> Self {
        return initFromStoryboard(name: "Main", identifier: "LoginViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.isEnabled = false
        
        let validUser = usernameTextField
            .reactive
            .continuousTextValues
            .skipNil()
            .map(presenter.isValidEmail)
        
        let validPassword = passwordTextField
            .reactive
            .continuousTextValues
            .skipNil()
            .map(presenter.isValidPassword)
        
        // http://rxmarbles.com/#combineLatest
        validUser
            .combineLatest(with: validPassword)
            .observe(on: UIScheduler())
            .map({ $0 && $1 })
            .observeValues { isEnabled in
                self.loginButton.isEnabled = isEnabled
            }
        
        loginButton
            .reactive
            .controlEvents(.touchUpInside)
            .observeValues(login)
    }
    
    private func login(button: UIButton) {
        print("Starting login...")
        presenter.login(username:  usernameTextField.text!,
                        password: passwordTextField.text!)
    }
    
    // LoginView functions
    
    func presentAlert(title: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil) )
        
        present(alert, animated: true, completion: nil)
    }
}
