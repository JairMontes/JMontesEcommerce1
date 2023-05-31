//
//  rolCell.swift
//  JMontesEcommerce
//
//  Created by Admin on 09/05/23.
//

import UIKit
import SwipeCellKit

class rolCell: SwipeTableViewCell {

    @IBOutlet weak var lblIdRol: UILabel!
    @IBOutlet weak var lblNombre: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
