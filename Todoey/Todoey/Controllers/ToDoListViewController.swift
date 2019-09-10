//
//  ViewController.swift
//  Todoey
//
//  Created by Abrish Sabri on 9/9/19.
//  Copyright © 2019 Abrish Sabri. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    //let defaults = UserDefaults.standard
    
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        print(dataFilePath)
        
        
        loadItems()

        
//        if let items = UserDefaults.standard.array(forKey: "ToDoListArray") as? [String] {
//            itemArray = items
//        }
        
    }
    
    
    //MARK - Tableview Datasource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
//         if itemArray[indexPath.row].done == true {
//            cell.accessoryType = .checkmark
//        }
//         else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    //MARK - Tableview delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        }
//        else {
//            itemArray[indexPath.row].done = false
//        }
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Model Manipulation Methods
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: self.dataFilePath!)
        }
        catch {
            print("Enter encoding item array, \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    func loadItems(){
       if let data = try? Data(contentsOf: dataFilePath!) {
        let decoder = PropertyListDecoder()
        do
        {
            itemArray = try decoder.decode([Item].self, from: data)
        }
        catch {
            print("Error decoding \(error)")
            }
        }
    }

}

