//
//  LoginVC.swift
//  BasicToDo
//
//  Created by yekta on 22.02.2024.
//

import UIKit
import Firebase
class LoginVC: UIViewController {
    private var loginViewModel = LoginViewModel()
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let button = UIButton(type: .system)
    @objc let createAccButton = UIButton(type: .system)
    let myButtonColor = UIColor(named: "buttonColor")
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .secondarySystemBackground
        setupBindings()
        
        //create a button
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor(named: "buttonColor")
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        //auto layout button
        NSLayoutConstraint.activate([
            //center button
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -250), //from bottom to top
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor), //center x
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        createAccButton.setTitle("Register", for: .normal)
        createAccButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        createAccButton.backgroundColor = UIColor(named: "buttonColor")
        createAccButton.tintColor = .white
        createAccButton.translatesAutoresizingMaskIntoConstraints = false
        createAccButton.layer.cornerRadius = 20
        createAccButton.layer.masksToBounds = true
        self.view.addSubview(createAccButton)
        createAccButton.addTarget(self, action: #selector(createAccButtonAction), for: .touchUpInside)
        
        //auto layout button
        NSLayoutConstraint.activate([
            //center button
            createAccButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -175), //from bottom to top
            createAccButton.centerXAnchor.constraint(equalTo: view.centerXAnchor), //center x
            createAccButton.widthAnchor.constraint(equalToConstant: 125),
            createAccButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        setupTextFields()
    }
    
    //to homeVC
    @objc func buttonAction(sender: UIButton!) {
        guard let email = usernameTextField.text, !email.isEmpty,
                      let password = passwordTextField.text, !password.isEmpty else {
                    print("Email or/and password cannot null.")
                    return
                }
        loginViewModel.email = email
        loginViewModel.password = password
        loginViewModel.loginUser()
    }
    @objc func createAccButtonAction(sender: UIButton!) {
        let RegisterVC = RegisterVC()
        self.navigationController?.pushViewController(RegisterVC, animated: true)
    }
    func setupBindings(){
        let homeVC = HomeVC()
        loginViewModel.onLoginSuccess = { [weak self] in
            DispatchQueue.main.async {
                self?.navigationController?.pushViewController(homeVC, animated: true)
            }
        }
        loginViewModel.onLoginFailure = { error in
            DispatchQueue.main.async {
                // Hata mesajını kullanıcıya göster
                print(error.localizedDescription)
            }
        }
    }
    func setupTextFields() {
        // Kullanıcı adı TextField ayarları
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.borderStyle = .roundedRect
        let usernamePlaceholder = NSAttributedString(string: "Username",
                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        usernameTextField.attributedPlaceholder = usernamePlaceholder
        usernameTextField.layer.borderWidth = 1.5
        usernameTextField.layer.cornerRadius = 10
        usernameTextField.layer.borderColor = myButtonColor?.cgColor
        
        // Şifre TextField ayarları
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.borderStyle = .roundedRect
        let passwordPlaceholder = NSAttributedString(string: "Password",
                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        passwordTextField.attributedPlaceholder = passwordPlaceholder
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.borderWidth = 1.5
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderColor = myButtonColor?.cgColor
        
        // TextField'ları view'a ekle
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            // Kullanıcı adı TextField'ını merkezle ve genişliğini ayarla
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Şifre TextField'ını kullanıcı adı TextField'ının hemen altına yerleştir
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 15),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}
