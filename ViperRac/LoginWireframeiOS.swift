import Foundation
import UIKit

// Podemos importar UIKit y trabajar la navegación para el caso concreto de iOS
class LoginWireframeiOS: LoginWireframe {
    let navigationController: UINavigationController
    let dependencies: DependenciesiOS
    
    init(navigationController: UINavigationController, dependencies: DependenciesiOS) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func presentMainView() {
        let wireframe = dependencies.loginWireframe(navigationController: navigationController)
        let vc = dependencies.loginViewController(wireframe: wireframe)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
