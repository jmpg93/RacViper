import Foundation

/// Dependencias que se podrían compartir entre diferentes plataformas (Controladores y Presenters). 
public class SharedDependencies {
    
    lazy var userDefaults: UserDefaults = {
        return .standard
    }()
    
    // Controllers
    // Una sola instancia por controlador creada y mantenida por SharedDependencies
    
    lazy var userController: UserController = {
       return FakeUserController()
    }()
    
    lazy var persistanceController: PersistanceController = {
        return UserDefaultsPersistaceController(userDefaults: self.userDefaults)
    }()
    
    // Interactors
    
    lazy var userInteractor: UserInteractor = {
        return DefaultUserInteractor(userController: self.userController,
                                     persistanceController: self.persistanceController)
    }()
    
    // Presenters
    // Funciones para crear instancias de los presenters
    
    func loginPresenter(view: LoginView, wireframe: LoginWireframe) -> LoginPresenter {
        return DefaultLoginPresenter(view: view,
                                     wireframe: wireframe,
                                     userInteractor: userInteractor)
    }
}
