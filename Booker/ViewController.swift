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
    
    let books = [Books]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchBooks()
    }
    
    func addBook() {
        
    }
    
    func updateBook() {
        
    }
    
    func removeBook() {
        
    }
    
    func fetchBooks() {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? BookCell
        return cell!
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        let popup = UIAlertController(title: "Add Book", message: "Add a new book.", preferredStyle: .alert)
        popup.addTextField { (textField) in
            textField.placeholder = "Book's name"
        }
        
        let saveAction = UIAlertAction(title: "Add", style: .default) { (_) in
//            self.addBook(listItem: popup.textFields?.first?.text ?? "Error")
            self.fetchBooks()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        popup.addAction(saveAction)
        popup.addAction(cancelAction)
        self.present(popup, animated: true, completion: nil)
    }
}
