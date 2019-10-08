//
//  ViewController.swift
//  Booker
//
//  Created by Can Balkaya on 10/8/19.
//  Copyright © 2019 Can Balkaya. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchBooks()
    }
    
    func addBook(name: String, topic: String, author: String, isRead: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Books", in: managedContext)!
        
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        item.setValue(name, forKey: "name")
        item.setValue(topic, forKey: "topic")
        item.setValue(author, forKey: "author")
        item.setValue(isRead, forKey: "isRead")
        
        do {
            try managedContext.save()
        } catch let error{
            print("Item can't be created: \(error.localizedDescription)")
        }
    }
    
    func updateBook() {
        
    }
    
    func removeBook() {
        
    }
    
    func fetchBooks() {
        books.removeAll()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Books")
        
        do {
            let fetchResults = try managedContext.fetch(fetchRequest)
            
            for item in fetchResults as! [NSManagedObject] {
                books.append(Book(booksName: item.value(forKey: "name") as! String, booksTopic: item.value(forKey: "topic") as! String, booksAuthor: item.value(forKey: "author") as! String, isRead: false, timestamp: Date()))
            }
            
            tableView.reloadData()
        } catch let error{
            print(error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? BookCell
//        cell?.nameLabel.text = books[indexPath.row].booksName
//        cell?.topicLabel.text = books[indexPath.row].booksTopic
//        cell?.authorLabel.text = books[indexPath.row].booksAuthor
//        cell?.isReadImage!.image = #imageLiteral(resourceName: "Off")
        
//        if books[indexPath.row].isRead == false {
//
//        } else {
//            cell?.isReadImage!.image = #imageLiteral(resourceName: "On")
//        }
        cell!.configureCell(book: books[indexPath.row])
        
        return cell!
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
            self.addBook(name: popup.textFields![0].text!, topic: popup.textFields![1].text!, author: popup.textFields![2].text!, isRead: false)
            self.fetchBooks()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        popup.addAction(saveAction)
        popup.addAction(cancelAction)
        self.present(popup, animated: true, completion: nil)
    }
}
