import Foundation

enum UserInteractorError: Error {
    case persistanceError(PersistanceError)
    case loginError(LoginError)
    
    static func fromPersistanceError(error: PersistanceError) -> UserInteractorError {
        return .persistanceError(error)
    }
    
    static func fromLoginError(error: LoginError) -> UserInteractorError {
        return .loginError(error)
    }
}
