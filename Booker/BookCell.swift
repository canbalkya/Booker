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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var isReadImage: UIImageView!
    
    private var book: Book!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(book: Book) {
        self.book = book
        
        nameLabel.text = book.booksName
        topicLabel.text = book.booksTopic
        authorLabel.text = book.booksAuthor
        isReadImage.image = book.isReadImage
        
        isReadImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        isReadImage.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func selectImage() {
        book.isRead = false
        
        if book.isRead {
            isReadImage.image = #imageLiteral(resourceName: "On")
        } else {
            isReadImage.image = #imageLiteral(resourceName: "Off")
        }
    }
}
