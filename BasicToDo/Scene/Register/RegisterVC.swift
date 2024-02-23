//
//  RegisterVC.swift
//  BasicToDo
//
//  Created by yekta on 23.02.2024.
//

import UIKit

class RegisterVC: UIViewController {
    private var registerViewModel = RegisterViewModel()
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let button = UIButton(type: .system)
    let myButtonColor = UIColor(named: "buttonColor")
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .secondarySystemBackground
        //create a button
        button.setTitle("Register", for: .normal)
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
        
        func setupTextFields() {
           
            usernameTextField.translatesAutoresizingMaskIntoConstraints = false
            usernameTextField.borderStyle = .roundedRect
            let usernamePlaceholder = NSAttributedString(string: "Username",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                                                      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
            usernameTextField.attributedPlaceholder = usernamePlaceholder
            usernameTextField.layer.borderWidth = 1.5
            usernameTextField.layer.cornerRadius = 10
            usernameTextField.layer.borderColor = myButtonColor?.cgColor
            
          
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
            
            
            view.addSubview(usernameTextField)
            view.addSubview(passwordTextField)
            
            NSLayoutConstraint.activate([
                
                usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
                usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                
                
                passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 15),
                passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ])
        }
        setupTextFields()
    }
    @objc func buttonAction(sender: UIButton!) {
        guard let email = usernameTextField.text, !email.isEmpty,
                      let password = passwordTextField.text, !password.isEmpty else {
                    print("Email or/and password cannot null.")
                    return
                }
        registerViewModel.email = email
        registerViewModel.password = password
        registerViewModel.createUser()
        }
    }

