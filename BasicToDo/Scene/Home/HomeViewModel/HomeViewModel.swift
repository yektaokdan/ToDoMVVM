//
//  HomeViewModel.swift
//  BasicToDo
//
//  Created by yekta on 22.02.2024.
//

import Foundation
class HomeViewModel{
    private var items : [ToDoItem] = []
    var itemCount:Int{
        return items.count
    }
    func item(at index: Int) ->ToDoItem{
        return items[index]
    }
    func addItem(title:String){
        let newItem = ToDoItem(id: UUID().uuidString, title: title, isCompleted: false)
        items.append(newItem)
    }
    func deleteItem(at index:Int){
        items.remove(at: index)
    }
    func toggleCompletion(at index: Int){
        items[index].isCompleted.toggle()
    }
    
}
