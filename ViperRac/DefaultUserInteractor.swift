import Foundation
import ReactiveSwift

class DefaultUserInteractor: UserInteractor {
    private let userController: UserController
    private let persistanceController: PersistanceController
    
    init(userController: UserController, persistanceController: PersistanceController) {
        self.userController = userController
        self.persistanceController = persistanceController
    }
    
    func login(username: String, password: String) -> SignalProducer<Void, UserInteractorError> {
        return userController
            .login(username: username, password: password)
            .mapError(UserInteractorError.fromLoginError)
            .flatMap(.concat, transform: storeUser)
    }
    
    // Private methods
    
    private func storeUser(user: String) -> SignalProducer<Void, UserInteractorError> {
        return persistanceController
            .store(user: user)
            .mapError(UserInteractorError.fromPersistanceError)
    }
}
