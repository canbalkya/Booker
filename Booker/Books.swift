//
//  Books.swift
//  Booker
//
//  Created by Can Balkaya on 10/8/19.
//  Copyright © 2019 Can Balkaya. All rights reserved.
//

import UIKit
import CoreData

class Books {
    var booksName: String
    var booksTopic: String
    var booksAuthor: String
    var isRead: Bool
    var image: UIImage
    
    init(booksName: String, booksTopic: String, booksAuthor: String, isRead: Bool, image: UIImage) {
        self.booksName = booksName
        self.booksTopic = booksTopic
        self.booksAuthor = booksAuthor
        self.isRead = isRead
        self.image = image
    }
}
