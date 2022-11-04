//
//  ViewController.swift
//  NotePad
//
//  Created by admin on 30.10.22.
//

import UIKit
import CoreData

class ModuleViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadModules()
    }
     
    var modules = [Module]()
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//    Mark: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modules.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ModuleCell", for: indexPath)
        
        cell.textLabel?.text = modules[indexPath.row].name
        
        return cell
    }
    
//    Mark: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToLessons", sender: self)
        saveModules()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! LessonViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedModule = modules[indexPath.row]
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Module", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add  Module", style: .default) { (action) in
            let newModule = Module(context: self.context)
            newModule.name = textField.text!
            self.modules.append(newModule)
            
            self.saveModules()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new module"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    
    func saveModules() {
        do {
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadModules(with request: NSFetchRequest<Module> = Module.fetchRequest()) {
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        do {
            modules = try context.fetch(request)
        } catch {
           print("Error fetching data from context, \(error)")
        }
        tableView.reloadData()
    }
    
 
    
    
    
}

