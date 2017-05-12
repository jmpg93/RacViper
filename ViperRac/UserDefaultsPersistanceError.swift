import Foundation
import ReactiveSwift

class UserDefaultsPersistaceController: PersistanceController {
    enum Constants {
        static let UserKey = "User"
    }
    
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func store(user: User) -> SignalProducer<Void, PersistanceError> {
        return SignalProducer { observer, disposable in
            self.userDefaults.set(user, forKey: Constants.UserKey)
            observer.sendCompleted()
        }
    }
    
    func retrieve(user: User) -> SignalProducer<User, PersistanceError> {
        return SignalProducer { observer, disposable in
            guard let user = self.userDefaults.string(forKey: Constants.UserKey) else {
                observer.send(error: .notFoundError)
                return
            }
            
            observer.send(value: user)
            observer.sendCompleted()
        }
    }
}
