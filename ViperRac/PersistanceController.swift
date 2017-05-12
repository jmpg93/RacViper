import Foundation
import ReactiveSwift
import Result

protocol PersistanceController {
    func store(user: User) -> SignalProducer<Void, PersistanceError>
    func retrieve(user: User) -> SignalProducer<User, PersistanceError>
}
