//
//  Books.swift
//  Booker
//
//  Created by Can Balkaya on 10/8/19.
//  Copyright © 2019 Can Balkaya. All rights reserved.
//

import UIKit
import CoreData

class Book {
    var booksImage: UIImage
    var booksName: String
    var booksTopic: String
    var booksAuthor: String
    var isRead: Bool
    var timestamp: Date
    var isReadImage: UIImage
    
    init(booksImage: UIImage, booksName: String, booksTopic: String, booksAuthor: String, isRead: Bool, timestamp: Date, isReadImage: UIImage) {
        self.booksImage = booksImage
        self.booksName = booksName
        self.booksTopic = booksTopic
        self.booksAuthor = booksAuthor
        self.isRead = isRead
        self.timestamp = timestamp
        self.isReadImage = isReadImage
    }
}
