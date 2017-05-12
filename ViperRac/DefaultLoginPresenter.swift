import Foundation
import ReactiveSwift

// Implementamos el caso concreto del protocolo LoginPresenter.
class DefaultLoginPresenter: LoginPresenter {
    // Referencias a protocolos.
    private weak var view: LoginView? // Propiedad weak para evitar leaks por un ciclo.
    private let wireframe: LoginWireframe
    private let userInteractor: UserInteractor
    
    init(view: LoginView, wireframe: LoginWireframe, userInteractor: UserInteractor) {
        self.view = view
        self.wireframe = wireframe
        self.userInteractor = userInteractor
    }
    
    func login(username: String, password: String) {
        userInteractor
            .login(username: username, password: password)
            .observe(on: UIScheduler())
            .startWithResult { result in
                switch result {
                case .success:
                    print("Login ok")
                    // Navegación.
                    self.wireframe.presentMainView()
                case .failure:
                    print("Login error")
                    // Comunicación con la vista a través del protocolo.
                    self.view?.presentAlert(title: "Error")
                }
        }
    }
    
    func isValidPassword(pass: String) -> Bool {
        return pass.characters.count > 3
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        
        return emailPredicate.evaluate(with: email)
    }
}
