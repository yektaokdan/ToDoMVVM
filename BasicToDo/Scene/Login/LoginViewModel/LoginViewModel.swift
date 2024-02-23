//
//  LoginViewModel.swift
//  BasicToDo
//
//  Created by yekta on 22.02.2024.
//

import Foundation
import Firebase
class LoginViewModel{
    var email:String?
    var password:String?
    var onLoginSuccess:(()->Void)?
    var onLoginFailure:((Error)->Void)?
    func loginUser() {
            guard let email = email, let password = password else {
                print("E-posta veya şifre boş olamaz")
                return
            }
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let error = error {
                    // Hata durumunda hata mesajını gönder
                    self?.onLoginFailure?(error)
                    return
                }
                
                // Giriş başarılı olduğunda ilgili işlemi yap
                self?.onLoginSuccess?()
            }
        }
}
