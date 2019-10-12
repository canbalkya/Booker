//
//  ViewController.swift
//  Booker
//
//  Created by Can Balkaya on 10/8/19.
//  Copyright © 2019 Can Balkaya. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var books = [Book]()
    let search = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        search.searchBar.delegate = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Find a book"
        search.searchResultsUpdater = self as? UISearchResultsUpdating
        navigationItem.searchController = search
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchBooks()
    }
    
    func addBook(name: String, topic: String, author: String, isRead: Bool, timestamp: Date, isReadImage: UIImage) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Books", in: managedContext)!
        
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        item.setValue(name, forKey: "name")
        item.setValue(topic, forKey: "topic")
        item.setValue(author, forKey: "author")
        item.setValue(isRead, forKey: "isRead")
        item.setValue(timestamp, forKey: "timestamp")
        item.setValue(isReadImage, forKey: "isReadImage")
        
        do {
            try managedContext.save()
        } catch let error {
            print("Item can't be created: \(error.localizedDescription)")
        }
    }
    
    func updateBook(name: String, topic: String, author: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Books")
        fetchRequest.predicate = NSPredicate(format: "book = %@", name, topic, author)
        
        let popup = UIAlertController(title: "Update", message: "Update book's informations.", preferredStyle: .alert)
        popup.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        
        popup.addTextField { (textField) in
            textField.placeholder = "Topic"
        }
        
        popup.addTextField { (textField) in
            textField.placeholder = "Author"
        }
        
        let changeAction = UIAlertAction(title: "Change", style: .default) { (_) in
            do {
                let result = try managedContext.fetch(fetchRequest)
                result[0].setValue(popup.textFields![0].text, forKey: "name")
                result[1].setValue(popup.textFields![1].text, forKey: "topic")
                result[2].setValue(popup.textFields![2].text, forKey: "author")
            } catch let error {
                print(error.localizedDescription)
            }
            
//            if let result = try? managedContext.fetch(fetchRequest) {
//                for book in result {
//                    managedContext.delete(book)
//                }
//
//                self.addBook(name: popup.textFields![0].text!, topic: popup.textFields![1].text!, author: popup.textFields![2].text!, isRead: false, timestamp: Date())
//
//                do {
//                    try managedContext.save()
//                } catch let error {
//                    print(error.localizedDescription)
//                }
//            }
            
            self.fetchBooks()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        popup.addAction(changeAction)
        popup.addAction(cancelAction)
        self.present(popup, animated: true, completion: nil)
    }
    
    func removeBook(name: String, topic: String, author: String, isRead: Bool, timestamp: Date) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Books")
        fetchRequest.predicate = NSPredicate(format: "book = %@", name, topic, author, isRead, timestamp as CVarArg)

        if let result = try? managedContext.fetch(fetchRequest) {
            for book in result {
                managedContext.delete(book)
            }

            do {
                try managedContext.save()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchBooks() {
        books.removeAll()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Books")
        
        do {
            let fetchResults = try managedContext.fetch(fetchRequest)
            
            for item in fetchResults as! [NSManagedObject] {
                books.append(Book(booksName: item.value(forKey: "name") as! String, booksTopic: item.value(forKey: "topic") as! String, booksAuthor: item.value(forKey: "author") as! String, isRead: item.value(forKey: "isRead") as? Bool ?? false, timestamp: item.value(forKey: "timestamp") as? Date ?? Date(), isReadImage: item.value(forKey: "isReadImage") as? UIImage ?? UIImage(named: "Off")!))
            }
            
            tableView.reloadData()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? BookCell
        cell!.configureCell(book: books[indexPath.row])
        return cell!
    }
    
    func tableView(_tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, UIView, (Bool) -> Void) in
            
            let moc = self.getContext()
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Books")
            
            let result = try? moc.fetch(fetchRequest)
            let resultData = result as! [NSManagedObject]
            
            for object in resultData {
                if let name = object.value(forKey: "name") as? String {
                    if name == self.books[indexPath.row].booksName {
                        moc.delete(object)
                        self.books.remove(at: indexPath.row)
                        self.tableView.reloadData()
                        
                        do {
                            try moc.save()
                        } catch let error as NSError  {
                            print("Could not save \(error), \(error.userInfo)")
                        } catch {
                            
                        }
                        
                        break
                    }
                }
            }
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let update = UIContextualAction(style: .normal, title: "Update") { (action, UIView, (Bool) -> Void) in
            self.updateBook(name: self.books[indexPath.row].booksName, topic: self.books[indexPath.row].booksTopic, author: self.books[indexPath.row].booksAuthor)
            self.fetchBooks()
            tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [update])
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        let popup = UIAlertController(title: "Add Book", message: "Add a new book.", preferredStyle: .alert)
        popup.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        
        popup.addTextField { (textField) in
            textField.placeholder = "Topic"
        }
        
        popup.addTextField { (textField) in
            textField.placeholder = "Author"
        }
        
        let saveAction = UIAlertAction(title: "Add", style: .default) { (_) in
            self.addBook(name: popup.textFields![0].text!, topic: popup.textFields![1].text!, author: popup.textFields![2].text!, isRead: false, timestamp: Date(), isReadImage: UIImage(named: "Off")!)
            self.fetchBooks()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        popup.addAction(saveAction)
        popup.addAction(cancelAction)
        self.present(popup, animated: true, completion: nil)
    }
}
