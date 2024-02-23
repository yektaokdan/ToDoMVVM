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
        // TableView'i view'a ekleyin
        view.addSubview(tableView)
        
        // TableView için constraints ayarlayın
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        
        // Cell kaydı
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
        
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
                viewModel.deleteItem(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
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
                
                self?.viewModel.addItem(title: title)
                self?.tableView.reloadData()
            }
        }
        alertController.addAction(addAction)
        let cancelAction = UIAlertAction(title: alertConstants.addToDoAppCancelAction, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

}
