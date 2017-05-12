import Foundation
import ReactiveSwift

// Definimos las funciones necesarias para la comunicación con la View 
protocol LoginPresenter: Presenter {
    // Lógica de negocio
    func login(username: String, password: String)
    
    // Lógica de vista
    func isValidEmail(email: String) -> Bool
    func isValidPassword(pass: String) -> Bool
}
