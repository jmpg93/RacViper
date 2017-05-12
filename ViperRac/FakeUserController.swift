import Foundation
import ReactiveSwift

class FakeUserController: UserController {
    private let queue = QueueScheduler(qos: .userInitiated, name: "jmpg93.viperRac.userController")
    
    func login(username: String, password: String) -> SignalProducer<User, LoginError> {
        return SignalProducer { observer, _ in
            sleep(3)
            if Bool.random {
                observer.send(error: .networkError)
            } else {
                observer.send(value: username)
                observer.sendCompleted()
            }
        }
    }
}
