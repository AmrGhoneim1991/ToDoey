//
//  ViewController.swift
//  Todoey
//
//  Created by amr ahmed abdel hamied on 3/30/20.
//  Copyright © 2020 amr ahmed abdel hamied. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["cell1" , "cell2" ,"cell3"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
// Mark - table view datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let index = indexPath.row
        cell.textLabel?.text = itemArray[index]
        return cell
    }
    
//     Mark - Table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

