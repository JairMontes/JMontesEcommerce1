//
//  productoCell.swift
//  JMontesEcommerce
//
//  Created by Admin on 16/05/23.
//

import UIKit
import SwipeCellKit

class productoCell: SwipeTableViewCell {

 
    
    @IBOutlet weak var lblNombre: UILabel!
    
    @IBOutlet weak var lblPrecio: UILabel!
    
    @IBOutlet weak var lblDescripcion: UILabel!
    
    
    @IBOutlet weak var ImagenView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
