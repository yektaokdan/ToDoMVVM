//
//  HomeViewModel.swift
//  BasicToDo
//
//  Created by yekta on 22.02.2024.
//

import Foundation
import Firebase
class HomeViewModel{
    private var items : [ToDoItem] = []
    var itemCount:Int{
        return items.count
    }
    func item(at index: Int) ->ToDoItem{
        return items[index]
    }
    func addItem(title: String, tableView:UITableView) {
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("items").addDocument(data: [
            "title": title,
            "isCompleted": false,
            // Diğer alanlarınız varsa buraya ekleyin
        ]) { [weak self] err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                // Veri başarılı bir şekilde eklendi, şimdi lokal listeyi güncelleyin
                let newItem = ToDoItem(id: ref!.documentID, title: title, isCompleted: false)
                self?.items.append(newItem)
                
                // Ana iş parçacığında tableView'ı yenileyin
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        }
    }

    func fetchItems(tableView:UITableView) {
        let db = Firestore.firestore()
        db.collection("items").whereField("userID", isEqualTo: Auth.auth().currentUser?.uid ?? "unknownUser")
            .getDocuments() { [weak self] (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self?.items = querySnapshot!.documents.map { document -> ToDoItem in
                        let data = document.data()
                        let title = data["title"] as? String ?? ""
                        let isCompleted = data["isCompleted"] as? Bool ?? false
                        return ToDoItem(id: document.documentID, title: title, isCompleted: isCompleted)
                    }
                    DispatchQueue.main.async {
                        tableView.reloadData()
                    }
                }
            }
    }
    
    
    
    func deleteItem(at index:Int, tableView: UITableView){
        let idToDelete = items[index].id
        
        let db = Firestore.firestore()
        
        db.collection("items").document(idToDelete).delete() {err in
            if let err = err{
                print("Error: \(err)")
            }
            else{
                self.items.remove(at: index)
                DispatchQueue.main.async {
                }
                print("Document successfully removed!")
                tableView.reloadData()
            }
        }
        
    }
    func toggleCompletion(at index: Int){
        items[index].isCompleted.toggle()
    }
    func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
            print("Exit process")
        } catch let signOutError {
            completion(signOutError)
        }
    }
    
}
