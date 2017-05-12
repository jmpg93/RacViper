import Foundation
import ReactiveSwift

class NetworkUserController: UserController {
    func login(username: String, password: String) -> SignalProducer<User, LoginError> {
        return SignalProducer { observer, _ in
            observer.send(value: username)
            observer.sendCompleted()
        }
    }
}
