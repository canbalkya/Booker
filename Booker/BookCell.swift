//
//  BookCell.swift
//  Booker
//
//  Created by Can Balkaya on 10/8/19.
//  Copyright © 2019 Can Balkaya. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var isReadButton: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBOutlet weak var isReadButtonTapped: UIImageView!
}
