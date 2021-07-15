//
//  SavedItemCell.swift
//  Lecture 54
//
//  Created by Nika Kirkitadze on 15.07.21.
//

import UIKit

class SavedItemCell: UITableViewCell, CellConfigurable {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with item: CellItem) {
        
    }
}
