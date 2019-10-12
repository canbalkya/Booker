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
    @IBOutlet weak var isReadButton: UIButton!
    
    private var book: Book!
    var a = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(book: Book) {
        self.book = book
        
        booksImage.image = book.booksImage
        nameLabel.text = book.booksName
        topicLabel.text = book.booksTopic
        authorLabel.text = book.booksAuthor
        isReadButton.imageView?.image = book.isReadImage
    }
        
    @IBAction func isReadButtonTapped(_ sender: UIButton) {
        a += 1
        
        if a.isMultiple(of: 2) {
            isReadButton.imageView?.image = UIImage(named: "square.fill")
        } else {
            isReadButton.imageView?.image = UIImage(named: "square")
        }
    }
}
