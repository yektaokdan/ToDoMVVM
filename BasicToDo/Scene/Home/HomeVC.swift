//
//  HomeVC.swift
//  BasicToDo
//
//  Created by yekta on 22.02.2024.
//

import UIKit

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    private var tableView :UITableView!
    private var viewModel = HomeViewModel()
    private var alertConstants = AlertConstants()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        self.navigationItem.hidesBackButton = true
        
        view.addSubview(tableView)
        
      
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Çıkış Yap", style: .plain, target: self, action: #selector(signOutTapped))

        viewModel.fetchItems(tableView:tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = viewModel.item(at: indexPath.row)
        cell.textLabel?.text = item.title
        cell.accessoryType = item.isCompleted ? .checkmark : .none
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                viewModel.deleteItem(at: indexPath.row, tableView: tableView)
            }
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            viewModel.toggleCompletion(at: indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    @objc func addNewItem() {
        makeToDoAddAlert(title: alertConstants.addToDoAppAlertTitle, message: alertConstants.addToDoAppAlertMessage)
    }
    func makeToDoAddAlert(title:String, message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = self.alertConstants.addToDoAppPlaceholder
        }
        let addAction = UIAlertAction(title: alertConstants.addToDoAppAddAction, style: .default) { [weak self] _ in
            if let title = alertController.textFields?.first?.text, !title.isEmpty {
                
                self?.viewModel.addItem(title: title, tableView: self!.tableView)
            }
        }
        alertController.addAction(addAction)
        let cancelAction = UIAlertAction(title: alertConstants.addToDoAppCancelAction, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    @objc func signOutTapped() {
        viewModel.signOut { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Çıkış yaparken hata oluştu: \(error.localizedDescription)")
                } else {
                    guard let self = self else { return }
                    let loginVC = LoginVC()
                    loginVC.modalPresentationStyle = .fullScreen
                    self.present(loginVC, animated: true, completion: nil)
                }
            }
        }
    }

}
