import Foundation
import ReactiveSwift

protocol UserInteractor {
    func login(username: String, password: String) -> SignalProducer<Void, UserInteractorError>
}
