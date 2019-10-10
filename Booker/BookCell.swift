//
//  BookCell.swift
//  Booker
//
//  Created by Can Balkaya on 10/8/19.
//  Copyright © 2019 Can Balkaya. All rights reserved.
//

import UIKit
import CoreData

class BookCell: UITableViewCell {
    @IBOutlet weak var booksImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var isReadImage: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    
    private var book: Book!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(book: Book) {
        self.book = book
        
        nameLabel.text = book.booksName
        topicLabel.text = book.booksTopic
        authorLabel.text = book.booksAuthor
        
        let formator = DateFormatter()
        formator.dateFormat = "EEEE, MMM d, yyyy HH:mm"
        
        let timestamp = formator.string(from: book.timestamp)
        timestampLabel.text = timestamp
    }
}
