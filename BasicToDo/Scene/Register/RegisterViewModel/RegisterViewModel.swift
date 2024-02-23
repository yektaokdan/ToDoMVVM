//
//  RegisterViewModel.swift
//  BasicToDo
//
//  Created by yekta on 23.02.2024.
//

import Foundation
import Firebase
class RegisterViewModel{
    var email:String?
    var password:String?
    var onCreateSuccess:(()->Void)?
    var onCreateFailure:((Error)->Void)?
    func createUser() {
            guard let email = email, let password = password else {
                print("Email or/and password cannot null")
                return
            }
            
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
                if let error = error {
                    // Hata durumunda hata mesajını gönder
                    self?.onCreateFailure?(error)
                    return
                }
                
                // Giriş başarılı olduğunda ilgili işlemi yap
                self?.onCreateSuccess?()
            }
        }
}
