//
//  LessonViewController.swift
//  NotePad
//
//  Created by admin on 31.10.22.
//

import UIKit
import CoreData

class LessonViewController: UITableViewController {
    
    var lessons = [Lesson]()
    var selectedModule: Module? {
        didSet{
            loadLessons()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return lessons.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonCell", for: indexPath)
        cell.textLabel?.text = lessons[indexPath.row].title
        return cell
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Lesson", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Lesson", style: .default) { action in
            let newLesson = Lesson(context: self.context)
            newLesson.title = textField.text!
            newLesson.parentModule = self.selectedModule
            
            self.lessons.append(newLesson)
            self.saveLessons()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new lesson"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    func saveLessons(){
        do {
            try context.save()
        } catch {
            print("Error saving contest \(error)")
        }
        tableView.reloadData()
    }
    
    func loadLessons(with request: NSFetchRequest<Lesson> = Lesson.fetchRequest(), predicate: NSPredicate? = nil) {
        
        let modulePredicate = NSPredicate(format: "parentModule.name MATCHES %@", selectedModule!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [modulePredicate, additionalPredicate])
        } else {
            request.predicate = modulePredicate
        }
        
        do {
            lessons = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
}
    
//Mark: - Search Bar Methods
    
extension LessonViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadLessons(with: request, predicate: predicate)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadLessons()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
           
        }
    }
}
    
    
