//
//  CategoryViewController.swift
//  Todoey
//
//  Created by amr ahmed abdel hamied on 4/2/20.
//  Copyright © 2020 amr ahmed abdel hamied. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
   var categories = [Category]()
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        laodCategories()

      
    }
        //MARK: - Data manipulation methods
    func saveCategories() {
        do {
            try context.save()
        }catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    func laodCategories() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categories = try context.fetch(request)
        }catch{
            print("error loading categories \(error)")
        }
        tableView.reloadData()
    }

    //MARK: - add new categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textFiled = UITextField()
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCatgeory = Category(context: self.context)
            newCatgeory.name = textFiled.text
            self.categories.append(newCatgeory)
            self.saveCategories()
        }
        alert.addAction(action)
        alert.addTextField { (filed) in
            textFiled = filed
            textFiled.placeholder = "Add a new Category"
        }
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - tableView data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell")!
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
    //MARK: - tableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }

    
    
}
