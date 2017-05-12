import Foundation
import ReactiveSwift

protocol UserController {
    func login(username: String, password: String) -> SignalProducer<User, LoginError>
}
